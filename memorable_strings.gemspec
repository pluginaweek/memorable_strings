$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'memorable_strings/version'

Gem::Specification.new do |s|
  s.name              = "memorable_strings"
  s.version           = MemorableStrings::VERSION
  s.authors           = ["Aaron Pfeifer"]
  s.email             = "aaron@pluginaweek.org"
  s.homepage          = "http://www.pluginaweek.org"
  s.description       = "Generates strings that can be easily remembered"
  s.summary           = "Easily remembered strings"
  s.require_paths     = ["lib"]
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- test/*`.split("\n")
  s.rdoc_options      = %w(--line-numbers --inline-source --title memorable_strings --main README.rdoc)
  s.extra_rdoc_files  = %w(README.rdoc CHANGELOG.rdoc LICENSE)
  
  s.add_development_dependency("rake")
  s.add_development_dependency("mocha")
end
