require File.dirname(__FILE__) + '/test_helper'

class StringByDefaultTest < Test::Unit::TestCase
  def setup
    @value = String.memorable
  end
  
  def test_should_have_8_characters
    assert_equal 8, @value.length
  end
  
  def test_should_not_include_capital_letter
    assert_no_match /[A-Z]/, @value
  end
  
  def test_should_not_include_digit
    assert_no_match /[0-9]/, @value
  end
  
  def test_should_be_consistent
    consistent = (1..100).each do
      value = String.memorable
      value =~ /^[a-z]+$/
    end
    
    assert consistent
  end
end

class StringTest < Test::Unit::TestCase
  def test_should_raise_exception_if_invalid_option_specified
    assert_raise(ArgumentError) { String.memorable(:invalid => true) }
  end
  
  def test_should_raise_exception_if_invalid_length
    assert_raise(ArgumentError) { String.memorable(:length => -1) }
    assert_raise(ArgumentError) { String.memorable(:length => 0) }
    assert_nothing_raised { String.memorable(:length => 1) }
  end
  
  def test_should_raise_exception_if_length_too_short_with_digits
    assert_raise(ArgumentError) { String.memorable(:length => 1, :digit => true) }
    assert_raise(ArgumentError) { String.memorable(:length => 2, :digit => true) }
    assert_nothing_raised { String.memorable(:length => 3, :digit => true) }
  end
end

class StringWithCustomLengthTest < Test::Unit::TestCase
  def setup
    @value = String.memorable(:length => 2)
  end
  
  def test_should_use_custom_length
    assert_equal 2, @value.length
  end
end

class StringWithCapitalTest < Test::Unit::TestCase
  def setup
    @value = String.memorable(:capital => true)
  end
  
  def test_should_have_8_characters
    assert_equal 8, @value.length
  end
  
  def test_include_capital
    assert_match /[A-Z]/, @value
  end
  
  def test_should_not_include_digit
    assert_no_match /[0-9]/, @value
  end
  
  def test_should_capitalize_with_length_of_1
    @value = String.memorable(:capital => true, :length => 1)
    assert_equal 1, @value.length
    assert_equal @value.upcase, @value
  end
  
  def test_should_be_consistent
    consistent = (1..100).all? do
      value = String.memorable(:capital => true)
      value =~ /^[a-z]*[A-Z][a-z]*$/
    end
    
    assert consistent
  end
end

class StringWithDigitTest < Test::Unit::TestCase
  def setup
    @value = String.memorable(:digit => true)
  end
  
  def test_should_have_8_characters
    assert_equal 8, @value.length
  end
  
  def test_not_include_capital
    assert_no_match /[A-Z]/, @value
  end
  
  def test_should_include_digit
    assert_match /[0-9]/, @value
  end
  
  def test_should_always_use_last_character_with_length_of_3
    @value = String.memorable(:digit => true, :length => 3)
    assert_equal 3, @value.length
    assert_match /[0-9]/, @value[-1, 1]
  end
  
  def test_should_be_consistent
    consistent = (1..100).all? do
      value = String.memorable(:digit => true)
      value =~ /^[a-z]+[0-9]{1}[a-z]*$/
    end
    
    assert consistent
  end
end

class StringWithCapitalAndDigitTest < Test::Unit::TestCase
  def setup
    @value = String.memorable(:capital => true, :digit => true)
  end
  
  def test_should_have_8_characters
    assert_equal 8, @value.length
  end
  
  def test_include_capital
    assert_match /[A-Z]/, @value
  end
  
  def test_should_include_digit
    assert_match /[0-9]/, @value
  end
  
  def test_should_be_consistent
    consistent = (1..100).all? do
      value = String.memorable(:capital => true, :digit => true)
      value =~ /^[a-z]*([A-Z][a-z]*[0-9]|[0-9][a-z]*[A-Z])[a-z]*$/
    end
    
    assert consistent
  end
end
