require './test/test_helper'

class EventTest < Minitest::Test
  def test_exists
    assert AppDirect::Event
  end

  def test_it_gives_back_a_single_customer
    VCR.use_cassette('one_customer') do
      event = AppDirect.retrieve("https://www.appdirect.com/rest/api/events/dummyOrder")
      assert_equal "STATELESS",event.flag 
    end
  end

end