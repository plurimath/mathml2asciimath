require 'simplecov'

SimpleCov.profiles.define 'gem' do
  add_filter '/spec/'
  add_filter '/autotest/'
  add_group 'Libraries', '/lib/'
end
SimpleCov.start 'gem'

require "rspec/match_fuzzy"
require 'mathml2asciimath'

