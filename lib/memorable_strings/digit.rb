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
    add 1, 2, 3, 4, 5, 6, 7, 8, 9
  end
end
