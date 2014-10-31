#test/test_helper.rb
require './lib/appdirect'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end

# If you need to record more test responses using VCR you need genuine AppDirect keys
# You can find them on the Edit Integration page of your AppDirect Product's dashboard.
AppDirect.consumer_key=ENV["APPDIRECT_KEY"] || "Dummy"
AppDirect.secret=ENV["APPDIRECT_SECRET"] || "secret"
