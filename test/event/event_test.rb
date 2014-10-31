require './test/test_helper'

class EventTest < Minitest::Test
  def test_exists
    assert AppDirect::Event
  end

  def test_it_retrieves_an_order_event
    VCR.use_cassette('dummy_order') do
      event = AppDirect::Event.retrieve("https://www.appdirect.com/rest/api/events/dummyOrder")    
      assert_equal "STATELESS",event.flag
      assert_equal "SUBSCRIPTION_ORDER",event.type
      assert_equal "test-email+creator@appdirect.com", event.creator.email
      assert_equal "BASIC", event.payload.order.editionCode
    end
  end

  def test_it_retrieves_a_change_event
    VCR.use_cassette('dummy_change') do
      event = AppDirect::Event.retrieve("https://www.appdirect.com/rest/api/events/dummyChange")    
      assert_equal "STATELESS",event.flag
      assert_equal "SUBSCRIPTION_CHANGE",event.type
      assert_equal "test-email+creator@appdirect.com", event.creator.email
      assert_equal "PREMIUM", event.payload.order.editionCode
      assert_equal "dummy-account", event.payload.account.accountIdentifier
    end
  end
  
  def test_it_retrieves_a_cancel_event
    VCR.use_cassette('dummy_cancel') do
      event = AppDirect::Event.retrieve("https://www.appdirect.com/rest/api/events/dummyCancel")    
      assert_equal "STATELESS",event.flag
      assert_equal "SUBSCRIPTION_CANCEL",event.type
      assert_equal "test-email+creator@appdirect.com", event.creator.email
      assert_equal "dummy-account", event.payload.account.accountIdentifier
    end
  end

  def test_it_retrieves_a_notice_event
    VCR.use_cassette('dummy_notice') do
      event = AppDirect::Event.retrieve("https://www.appdirect.com/rest/api/events/dummyNotice")    
      assert_equal "STATELESS",event.flag
      assert_equal "SUBSCRIPTION_NOTICE",event.type
      assert_equal "DEACTIVATED", event.payload.notice.type
    end
  end
end