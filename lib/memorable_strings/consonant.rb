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
    add %w(c f h j k m n p r t v w x y ch ph th)
    add %w(b d g q s z qu sh), :print_friendly => :downcase
    add %w(l), :print_friendly => false
    add :ng, :first => false
    add :gh, :first => false, :print_friendly => :downcase
  end
end
