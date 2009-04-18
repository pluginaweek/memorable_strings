module MemorableStrings
  # A unit of sound that can be used to build a larger string.  Phonemes have
  # no semantic meaning themselves, but have sound types and characteristics
  # associated with them that are helpful in building a discernable word.
  class Phoneme
    class << self
      # The collection of phonemes
      attr_reader :all
      
      # Adds a new phoneme of the current class's type.
      # 
      # See Phoneme#new for more information.
      def add(*values)
        options = values.last.is_a?(Hash) ? values.pop : {}
        
        values.flatten!
        values.map! do |value|
          (@all ||= []) << value = new(value, options)
          value
        end
        values.length == 1 ? values.first : values
      end
      
      # Generates a random phoneme for the current class of at most the given
      # length.  In addition, an optional block can be used to determine
      # whether the chosen phoneme is acceptable.
      # 
      # == Examples
      # 
      #   # Choose any vowel
      #   MemorableStrings::Vowel.random
      #   # => #<MemorableStrings::Vowel:0xb7c3efe4 @first=true, @value="e", @length=1>
      #   
      #   # Choose a vowel with at most 1 character
      #   MemorableStrings::Vowel.random(2)
      #   # => <MemorableStrings::Vowel:0xb7c3eb34 @first=true, @value="u", @length=1>
      #   
      #   # Choose a vowel that can be the first letter
      #   MemorableStrings::Vowel.random {|vowel| vowel.first?}
      #   # => #<MemorableStrings::Vowel:0xb7c3e080 @first=true, @value="a", @length=1>
      def random(maxlength = nil)
        phonemes = all
        phonemes = phonemes.select {|phoneme| phoneme.length <= maxlength} if maxlength
        
        begin
          phoneme = phonemes[rand(phonemes.size)]
        end while block_given? && !yield(phoneme)
        
        phoneme
      end
      
      # Generates a random phoneme of at most the given length.  This will
      # only randomly choose from the following sounds that are allowed to be
      # the first character:
      # * Vowel
      # * Consonant
      # 
      # == Examples
      # 
      #   MemorableStrings::Phoneme.first(1)
      #   #<MemorableStrings::Consonant:0xb7c38248 @first=true, @value="x", @length=1>
      #   
      #   MemorableStrings::Phoneme.first(2)
      #   #<MemorableStrings::Vowel:0xb7c3e2b0 @first=true, @value="ae", @length=2>
      def first(maxlength, &block)
        (rand(2) == 1 ? Vowel : Consonant).random(maxlength) do |phoneme|
          phoneme.first? && (!block_given? || block.call(phoneme))
        end
      end
    end
    
    # The character(s) representing this phoneme
    attr_reader :value
    
    # The number of characters
    attr_reader :length
    
    # Creates a new phoneme with the given value and configuration options.
    # 
    # Configuration options:
    # * <tt>:first</strong> - Whether it can be used as the first value in a
    #   string.  Default is true.
    def initialize(value, options = {})
      invalid_keys = options.keys - [:first]
      raise ArgumentError, "Invalid key(s): #{invalid_keys.join(', ')}" unless invalid_keys.empty?
      
      options = {:first => true}.merge(options)
      
      @value = value.to_s
      @length = @value.length
      @first = options[:first]
    end
    
    # Is this allowed to be the first in a sequence of phonemes?
    def first?
      @first
    end
  end
end
