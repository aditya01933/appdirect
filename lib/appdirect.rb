require "set"

require_relative "appdirect/version"
require_relative "appdirect/util"
require_relative "appdirect/appdirect_object"
require_relative "appdirect/event"

#Error declarations
require_relative "appdirect/errors/appdirect_error"
require_relative "appdirect/errors/authentication_error"

require 'oauth'
require 'nori'


module AppDirect
  class << self
    attr_accessor :consumer_key, :secret
  end

  def self.signed_get(event_url, consumer_key, secret, params={})
    unless consumer_key ||= @consumer_key
      raise AuthenticationError.new('No Consumer key provided. ' +
        'Set your Consumer key using "AppDirect.consumer_key = <CONSUMER-KEY>". ' +
        'You can view your consumer key via the AppDirect Edit Integration page. ')
    end

    if consumer_key =~ /\s/
      raise AuthenticationError.new('Your Consumer key is invalid, as it contains whitespace')
    end

    unless secret ||= @secret
      raise AuthenticationError.new('No API Secret provided. ' +
        'Set your Secret using "AppDirect.secret = <SECRET>". ' +
        'You can view your secret key via the AppDirect Edit Integration page. ')
    end

    if secret =~ /\s/
      raise AuthenticationError.new('Your API Secret is invalid, as it contains whitespace')
    end
    consumer = OAuth::Consumer.new(consumer_key, secret)
    access_token = OAuth::AccessToken.new(consumer)
    response = access_token.get(event_url)
    parser = Nori.new
    hash = parser.parse(response.body)
    [Util.symbolize_names(hash),consumer_key, secret]
  end
end
