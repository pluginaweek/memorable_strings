require File.dirname(__FILE__) + '/test_helper'

class DigitNextTest < Test::Unit::TestCase
  def setup
    setup_phonemes
    
    @digit = MemorableStrings::Digit.new(1)
    @stack = [@digit]
  end
  
  def test_should_generate_vowel_half_the_time
    MemorableStrings::Vowel.all << @a = MemorableStrings::Vowel.new(:a)
    
    MemorableStrings::Vowel.expects(:rand).at_least_once.returns(0)
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(1)
    
    assert_equal @a, @digit.next(@stack, 2)
  end
  
  def test_should_generate_consonant_half_the_time
    MemorableStrings::Consonant.all << @b = MemorableStrings::Vowel.new(:b)
    
    MemorableStrings::Consonant.expects(:rand).at_least_once.returns(0)
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(0)
    
    assert_equal @b, @digit.next(@stack, 2)
  end
  
  def test_should_allow_block_conditional
    MemorableStrings::Consonant.all << @b = MemorableStrings::Vowel.new(:b)
    MemorableStrings::Consonant.all << @c = MemorableStrings::Vowel.new(:c)
    MemorableStrings::Consonant.expects(:rand).with(2).times(2).returns(1, 0)
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(0)
    
    assert_equal @b, @digit.next(@stack, 2) {|phoneme| phoneme.value == 'b'}
  end
  
  def teardown
    teardown_phonemes
  end
end
