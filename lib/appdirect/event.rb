module AppDirect
  class Event < AppDirectObject

  def refresh
    response, consumer_key, secret = AppDirect.signed_get(@values[:id], @consumer_key, @secret, @retrieve_options)
    refresh_from(response[:event], consumer_key, secret)
  end

    def self.retrieve(url, consumer_key=nil, secret=nil)
      instance = self.new(url, consumer_key, secret)
      instance.refresh      
      instance
    end
  end
end