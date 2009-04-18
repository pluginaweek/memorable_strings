require File.dirname(__FILE__) + '/test_helper'

class PhonemeByDefaultTest < Test::Unit::TestCase
  def setup
    @phoneme = MemorableStrings::Phoneme.new(:a)
  end
  
  def test_should_have_a_value
    assert_equal 'a', @phoneme.value
  end
  
  def test_should_have_a_length
    assert_equal 1, @phoneme.length
  end
  
  def test_should_be_allowed_to_be_first
    assert @phoneme.first?
  end
  
  def test_should_be_print_friendly_with_downcase_context
    assert @phoneme.print_friendly?(:downcase)
  end
  
  def test_should_be_print_friendly_with_upcase_context
    assert @phoneme.print_friendly?(:upcase)
  end
end

class PhonemeTest < Test::Unit::TestCase
  def test_should_raise_exception_if_invalid_option_specified
    assert_raise(ArgumentError) { MemorableStrings::Phoneme.new(:a, :invalid => true) }
  end
end

class PhonemeWithMultipleCharactersTest < Test::Unit::TestCase
  def setup
    @phoneme = MemorableStrings::Phoneme.new(:ab)
  end
  
  def test_should_have_a_value
    assert_equal 'ab', @phoneme.value
  end
  
  def test_should_have_a_length
    assert_equal 2, @phoneme.length
  end
  
  def test_should_be_allowed_to_be_first
    assert @phoneme.first?
  end
end

class PhonemeNotFirstTest < Test::Unit::TestCase
  def setup
    @phoneme = MemorableStrings::Phoneme.new(:a, :first => false)
  end
  
  def test_should_not_be_allowed_to_be_first
    assert !@phoneme.first?
  end
end

class PhonemeNotPrintFriendlyTest < Test::Unit::TestCase
  def setup
    @phoneme = MemorableStrings::Phoneme.new(:i, :print_friendly => false)
  end
  
  def test_should_not_be_print_friendly_with_downcase_context
    assert !@phoneme.print_friendly?(:downcase)
  end
  
  def test_should_not_be_print_friendly_with_upcase_context
    assert !@phoneme.print_friendly?(:upcase)
  end
end

class PhonemeContextPrintFriendlyTest < Test::Unit::TestCase
  def setup
    @phoneme = MemorableStrings::Phoneme.new(:b, :print_friendly => :downcase)
  end
  
  def test_should_be_print_friendly_with_downcase_context
    assert @phoneme.print_friendly?(:downcase)
  end
  
  def test_should_not_be_print_friendly_with_upcase_context
    assert !@phoneme.print_friendly?(:upcase)
  end
end

class PhonemeMatchingTest < Test::Unit::TestCase
  def setup
    @phoneme = MemorableStrings::Phoneme.new(:a)
  end
  
  def test_should_match_if_no_block_given
    assert @phoneme.matches?
  end
  
  def test_should_pass_self_into_block
    context = nil
    @phoneme.matches? {|*args| context = args}
    
    assert_equal [@phoneme], context
  end
  
  def test_should_match_if_block_is_not_false
    assert @phoneme.matches? {true}
  end
  
  def test_should_not_match_if_block_is_false
    assert !@phoneme.matches? {false}
  end
end

class PhonemeCreationTest < Test::Unit::TestCase
  def test_should_add_phoneme_to_collection
    phoneme = MemorableStrings::Phoneme.add(:a)
    
    assert_equal [phoneme], MemorableStrings::Phoneme.all
    assert_equal 'a', phoneme.value
  end
  
  def test_should_allow_multiple_phonemes
    phonemes = MemorableStrings::Phoneme.add(:a, :b, :c, :first => false)
    
    assert_equal 3, phonemes.length
    assert_equal phonemes, MemorableStrings::Phoneme.all
    assert phonemes.all? {|phoneme| !phoneme.first?}
  end
  
  def test_should_allow_phoneme_arraye
    phonemes = MemorableStrings::Phoneme.add([:a, :b, :c], :first => false)
    
    assert_equal 3, phonemes.length
    assert_equal phonemes, MemorableStrings::Phoneme.all
    assert phonemes.all? {|phoneme| !phoneme.first?}
  end
  
  def teardown
    MemorableStrings::Phoneme.all.clear
  end
end

class PhonemeRandomTest < Test::Unit::TestCase
  def setup
    @a, @b, @ab = MemorableStrings::Phoneme.add(:a, :b, :ab)
  end
  
  def test_should_select_any_phoneme
    MemorableStrings::Phoneme.expects(:rand).with(3).returns(0)
    assert_equal @a, MemorableStrings::Phoneme.random
    
    MemorableStrings::Phoneme.expects(:rand).with(3).returns(1)
    assert_equal @b, MemorableStrings::Phoneme.random
  end
  
  def test_should_restrict_selection_based_on_maxlength
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(0)
    assert_equal @a, MemorableStrings::Phoneme.random(1)
  end
  
  def teardown
    MemorableStrings::Phoneme.all.clear
  end
end

class PhonemeRandomWithBlockTest < Test::Unit::TestCase
  def setup
    @a, @b = MemorableStrings::Phoneme.add(:a, :b)
  end
  
  def test_should_select_phoneme_that_returns_true
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(0)
    assert_equal @a, MemorableStrings::Phoneme.random {|phoneme| phoneme.value == 'a'}
    
    MemorableStrings::Phoneme.expects(:rand).with(2).times(2).returns(1, 0)
    assert_equal @a, MemorableStrings::Phoneme.random {|phoneme| phoneme.value == 'a'}
  end
  
  def teardown
    MemorableStrings::Phoneme.all.clear
  end
end

class PhonemeFirstTest < Test::Unit::TestCase
  def setup
    setup_phonemes
    
    MemorableStrings::Vowel.all << @a = MemorableStrings::Vowel.new(:a)
    MemorableStrings::Consonant.all << @b = MemorableStrings::Consonant.new(:b)
  end
  
  def test_should_select_vowel_half_the_time
    MemorableStrings::Vowel.expects(:rand).with(1).returns(0)
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(1)
    
    assert_equal @a, MemorableStrings::Phoneme.first(1)
  end
  
  def test_should_select_consonant_half_the_time
    MemorableStrings::Consonant.expects(:rand).with(1).returns(0)
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(0)
    
    assert_equal @b, MemorableStrings::Phoneme.first(1)
  end
  
  def test_should_not_select_phonemes_marked_as_not_first
    c = MemorableStrings::Consonant.add(:c, :first => false)
    
    MemorableStrings::Consonant.expects(:rand).with(2).times(2).returns(1, 0)
    MemorableStrings::Phoneme.expects(:rand).with(2).returns(0)
    
    assert_equal @b, MemorableStrings::Phoneme.first(1)
  end
  
  def teardown
    teardown_phonemes
  end
end
