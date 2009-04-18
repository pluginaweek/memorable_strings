require 'memorable_strings/phoneme'

module MemorableStrings
  # Represents a phoneme that begins with a consonant letter
  class Consonant < Phoneme
    # Generates a phoneme of at most the given length that should follow this
    # consononant.
    # 
    # This will always generate a vowel.
    def next(stack, maxlength, &block)
      Vowel.random(maxlength, &block)
    end
    
    # Bootstrap
    add %w(b c d f g h j k l m n p r s t v w x y z ch ph qu sh th)
    add %w(gh ng), :first => false
  end
end
