require File.dirname(__FILE__) + '/test_helper'

TIMES = 1000
LENGTH = 32

class PasswordGeneratorTest < Test::Unit::TestCase
  def test_should_generate_with_specific_length
    TIMES.times do |t|
      password = Password.generate(LENGTH)
      assert_equal LENGTH, password.length
    end
  end
  
  def test_should_generate_with_at_least_one_uppercase_letter
    TIMES.times do |t|
      password = Password.generate(LENGTH, Password::ONE_CASE)
      assert_match /[A-Z]/, password
      assert_equal LENGTH, password.length
    end
  end
  
  def test_should_generate_with_at_least_one_digit
    TIMES.times do |t|
      password = Password.generate(LENGTH, Password::ONE_DIGIT)
      assert_match /[0-9]/, password
      assert_equal LENGTH, password.length
    end
  end
  
  def test_should_generate_with_at_least_one_case_and_one_digit
    TIMES.times do |t|
      password = Password.generate(LENGTH, Password::ONE_CASE | Password::ONE_DIGIT)
      assert_match /[A-Z]/, password
      assert_match /[0-9]/, password
      assert_equal LENGTH, password.length
    end
  end
end
