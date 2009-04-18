require File.dirname(__FILE__) + '/test_helper'

class VowelWithPreviousVowelTest < Test::Unit::TestCase
  def setup
    setup_phonemes
    
    MemorableStrings::Consonant.all << @b = MemorableStrings::Vowel.new(:b)
    MemorableStrings::Consonant.all << @br = MemorableStrings::Vowel.new(:br)
    
    @previous = MemorableStrings::Vowel.new(:a)
    @vowel = MemorableStrings::Vowel.new(:e)
    @stack = [@previous, @vowel]
  end
  
  def test_should_generate_consonant_with_one_character
    MemorableStrings::Consonant.expects(:rand).with(1).returns(0)
    assert_equal @b, @vowel.next(@stack, 2)
  end
  
  def teardown
    teardown_phonemes
  end
end

class VowelWithMultipleCharactersTest < Test::Unit::TestCase
  def setup
    setup_phonemes
    
    MemorableStrings::Consonant.all << @b = MemorableStrings::Vowel.new(:b)
    MemorableStrings::Consonant.all << @br = MemorableStrings::Vowel.new(:br)
    
    @previous = MemorableStrings::Consonant.new(:c)
    @vowel = MemorableStrings::Vowel.new(:ai)
    @stack = [@previous, @vowel]
  end
  
  def test_should_generate_consonant_with_one_character
    MemorableStrings::Consonant.expects(:rand).with(1).returns(0)
    assert_equal @b, @vowel.next(@stack, 2)
  end
  
  def teardown
    teardown_phonemes
  end
end

class VowelNextTest < Test::Unit::TestCase
  def setup
    setup_phonemes
    
    @previous = MemorableStrings::Consonant.new(:c)
    @vowel = MemorableStrings::Vowel.new(:a)
    @stack = [@previous, @vowel]
  end
  
  def test_should_generate_vowel_forty_percent_the_time
    MemorableStrings::Vowel.all << @e = MemorableStrings::Vowel.new(:e)
    MemorableStrings::Vowel.all << @ee = MemorableStrings::Vowel.new(:ee)
    
    (0..3).each do |value|
      @vowel.expects(:rand).with(10).returns(value)
      MemorableStrings::Vowel.expects(:rand).with(1).returns(0)
      
      assert_equal @e, @vowel.next(@stack, 2)
    end
  end
  
  def test_should_generate_consonant_sixty_percent_the_time
    MemorableStrings::Consonant.all << @b = MemorableStrings::Vowel.new(:b)
    MemorableStrings::Consonant.all << @br = MemorableStrings::Vowel.new(:br)
    
    (4..9).each do |value|
      @vowel.expects(:rand).with(10).returns(value)
      MemorableStrings::Consonant.expects(:rand).with(1).returns(0)
      
      assert_equal @b, @vowel.next(@stack, 2)
    end
  end
  
  def test_should_allow_block_conditional
    MemorableStrings::Consonant.all << @b = MemorableStrings::Vowel.new(:b)
    MemorableStrings::Consonant.all << @c = MemorableStrings::Vowel.new(:c)
    MemorableStrings::Consonant.expects(:rand).with(2).times(2).returns(1, 0)
    @vowel.expects(:rand).returns(4)
    
    assert_equal @b, @vowel.next(@stack, 2) {|phoneme| phoneme.value == 'b'}
  end
  
  def teardown
    teardown_phonemes
  end
end
