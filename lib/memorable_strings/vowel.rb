require 'memorable_strings/phoneme'

module MemorableStrings
  # Represents a phoneme that begins with a vowel letter
  class Vowel < Phoneme
    # Generates a phoneme of at most the given length that should follow this
    # vowel.
    # 
    # If the last two characters in the stack (including this one) were
    # vowels, then this will always generate a consonant.  Otherwise, 40% of
    # the time it will generate a single-character vowel and 60% of the time
    # it will generate a consonant.
    # 
    # It is never possible for two consecutive vowel phonemes to result in
    # more than 2 vowel characters in the stack.
    def next(stack, maxlength, &block)
      previous = stack[-2]
      if previous && previous.is_a?(Vowel) || length > 1 || rand(10) > 3
        Consonant.random(1, &block)
      else
        Vowel.random(1, &block)
      end
    end
    
    # Bootstrap
    add %w(a e u ae ah ee)
    add %w(i o ai ei ie oh oo), :print_friendly => false
  end
end
