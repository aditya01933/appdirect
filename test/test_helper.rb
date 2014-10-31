#test/test_helper.rb
require './lib/appdirect'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end

AppDirect.consumer_key="Dummy"
AppDirect.secret="secret"
