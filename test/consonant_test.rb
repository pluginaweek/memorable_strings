require File.dirname(__FILE__) + '/test_helper'

class ConsonantNextTest < Test::Unit::TestCase
  def setup
    setup_phonemes
    
    MemorableStrings::Vowel.all << @a = MemorableStrings::Vowel.new(:a)
    @b = MemorableStrings::Consonant.new(:b)
    @stack = [@b]
  end
  
  def test_should_generate_a_vowel
    assert_equal @a, @b.next(@stack, 2)
  end
  
  def test_should_allow_block_conditional
    MemorableStrings::Vowel.all << @c = MemorableStrings::Vowel.new(:c)
    MemorableStrings::Vowel.expects(:rand).with(2).times(2).returns(1, 0)
    
    assert_equal @a, @b.next(@stack, 2) {|phoneme| phoneme.value == 'a'}
  end
  
  def teardown
    teardown_phonemes
  end
end
