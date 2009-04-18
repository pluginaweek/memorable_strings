require 'memorable_strings/phoneme'

module MemorableStrings
  # Represents a single-digit character
  class Digit < Phoneme
    # Generates a phoneme of at most the given length that should follow this
    # digit.
    # 
    # This will always randomly generate either a vowel or a consonant.
    def next(stack, maxlength, &block)
      Phoneme.first(maxlength, &block)
    end
    
    # Bootstrap
    add %w(3 4 7 9)
    add %w(0 1 2 5 6 8), :print_friendly => false
  end
end
