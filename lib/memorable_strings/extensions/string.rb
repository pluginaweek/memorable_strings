require 'memorable_strings/phoneme'
require 'memorable_strings/digit'
require 'memorable_strings/vowel'
require 'memorable_strings/consonant'

module MemorableStrings
  module Extensions #:nodoc:
    # Adds support for easily generating memorable strings
    module String
      # Generates a string based on a set of rules defining which characters
      # should be grouped together to form a memorable sequence.
      # 
      # Configuration options:
      # * <tt>:length</tt> - The length of the string to generate.  Default is 8.
      # * <tt>:capital</tt> - Whether to include a capital letter.  Default is false.
      # * <tt>:digit</tt> - Whether to include a digit.  Default is false.
      # 
      # == Examples
      # 
      #   String.memorable                                    # => "maikipeo"
      #   String.memorable(:length => 5)                      # => "quoge"
      #   String.memorable(:capital => true)                  # => "Bukievai"
      #   String.memorable(:digit => true)                    # => "ood4yosa"
      #   String.memorable(:capital => true, :digit => true)  # => "Goodah5e"
      # 
      # == Algorithm
      # 
      # See MemorableStrings::Consonant, MemorableStrings::Vowel, and
      # MemorableStrings::Digit for more information about how it's determined
      # which characters are allowed to follow which other characters.
      def memorable(options = {})
        invalid_keys = options.keys - [:length, :capital, :digit]
        raise ArgumentError, "Invalid key(s): #{invalid_keys.join(', ')}" unless invalid_keys.empty?
        
        length = options[:length] || 8
        raise ArgumentError, 'Length must be at least 1' if length < 1
        raise ArgumentError, 'Length must be at least 3 if using digits' if length < 3 && options[:digit]
        
        value = nil
        begin
          value = ''
          stack = []
          left = length
          flags = options.dup
          phoneme = nil
          
          begin
          	if !phoneme
          	  # Special-case first
          	  phoneme = Phoneme.first(left)
          	elsif flags[:digit] && stack.length >= 2 && rand(10) < 3
            	# Add digit in >= 3rd spot (30% chance)
            	flags.delete(:digit) 
        	    phoneme = Digit.random
      	    else
      	      # Choose next based on current phoneme
      	      phoneme = phoneme.next(stack, left)
          	end
          	
            # Track the phoneme
            stack << phoneme
            value << phoneme.value
            left -= phoneme.length
            
          	# Capitalize the first letter, phoneme after or a digit, or a consonant (30% chance)
          	if flags[:capital] && (stack.length == 1 || stack[-2].is_a?(Digit) || phoneme.is_a?(Consonant)) && rand(10) < 3
        	    flags.delete(:capital)
        	    value[-phoneme.length, 1] = value[-phoneme.length, 1].upcase!
          	end
          end while left > 0
        end while [:capital, :digit].any? {|key| flags.include?(key)}
        
        value
      end
    end
  end
end

String.class_eval do
  extend MemorableStrings::Extensions::String
end
