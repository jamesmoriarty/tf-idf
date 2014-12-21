require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'tfidf'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
