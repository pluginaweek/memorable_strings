require 'test/unit'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require File.dirname(__FILE__) + '/../init'

# Force mocha to be installed
begin
  require 'rubygems'
  require 'mocha'
rescue LoadError
  $stderr.puts "Mocha is not installed. `gem install mocha` and try again."
  exit
end

Test::Unit::TestCase.class_eval do
  def setup_phonemes
    @vowels = MemorableStrings::Vowel.all.dup
    @consonants = MemorableStrings::Consonant.all.dup
    @digits = MemorableStrings::Digit.all.dup
    
    MemorableStrings::Vowel.all.clear
    MemorableStrings::Consonant.all.clear
    MemorableStrings::Digit.all.clear
  end
  
  def teardown_phonemes
    MemorableStrings::Vowel.all.replace(@vowels)
    MemorableStrings::Consonant.all.replace(@consonants)
    MemorableStrings::Digit.all.replace(@digits)
  end
end
