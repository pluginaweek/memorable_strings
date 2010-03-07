# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{memorable_strings}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Pfeifer"]
  s.date = %q{2010-03-07}
  s.description = %q{Generates strings that can be easily remembered}
  s.email = %q{aaron@pluginaweek.org}
  s.files = ["lib/memorable_strings", "lib/memorable_strings/digit.rb", "lib/memorable_strings/vowel.rb", "lib/memorable_strings/phoneme.rb", "lib/memorable_strings/consonant.rb", "lib/memorable_strings/extensions", "lib/memorable_strings/extensions/string.rb", "lib/memorable_strings.rb", "test/vowel_test.rb", "test/test_helper.rb", "test/consonant_test.rb", "test/digit_test.rb", "test/string_test.rb", "test/phoneme_test.rb", "CHANGELOG.rdoc", "init.rb", "LICENSE", "Rakefile", "README.rdoc"]
  s.homepage = %q{http://www.pluginaweek.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pluginaweek}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Generates strings that can be easily remembered}
  s.test_files = ["test/vowel_test.rb", "test/consonant_test.rb", "test/digit_test.rb", "test/string_test.rb", "test/phoneme_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
