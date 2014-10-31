# AppDirect

Ruby bindings for the AppDirect Vendor API. Provides oauth signed retrieval of AppDirect events. Intended for use with the [AppDirect Subscription API](http://info.appdirect.com/developers/docs/api_integration/subscription_management)

Please note this is NOT an offical library and is not endorsed or supported by AppDirect.

## Installation

Add this line to your application's Gemfile:

    gem 'appdirect'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install appdirect

## Usage

### Configuration
The AppDirect API requires your own OAuth 1.0 Consumer Key and Secret. This is used to sign all get requests to the AppDirect REST API.

    #config/initializers/appdirect.rb
    AppDirect.consumer_key = "Dummy"
    AppDirect.secret = "secret"

### Retrieving an event
Subscription Management is intiated by a call from AppDirect to your defined callback urls. Part of this callback will include a URL parameter storing the URL for the event that you need to respond to.

For example you may have defined a callback URL as follows in your AppDirect integration settings

``https://example.com/create?url={eventUrl}``

Once you have retrieved the URL you can retrieve the Event:

          url = "https://www.appdirect.com/rest/api/events/dummyOrder" # <-- this should be the url from the callback
          event = AppDirect::Event.retrieve(url)
          
          #Inspect the event 
          if event.type == "SUBSCRIPTION_CANCEL"
            puts "Bad news, somebody just cancelled!"
          end

### Event data structure
As part of the retrieval the XML representation of the event is converted to a Ruby object, exposing the child elements of the ``<event>`` tag as methods on the event object.

In this SUBSCRIPTION_NOTICE XML example: 

    <event>
      <flag>STATELESS</flag>
      <marketplace>
        <baseUrl>https://acme.appdirect.com</baseUrl>
        <partner>ACME</partner>
      </marketplace>
      <payload>
        <account>
          <accountIdentifier>dummy-account</accountIdentifier>
          <status>SUSPENDED</status>
        </account>
        <configuration/>
        <notice>
          <type>DEACTIVATED</type>
        </notice>
      </payload>
      <type>SUBSCRIPTION_NOTICE</type>
    </event>

You can access the information as follows:
    
    event = AppDirect::Event.retrieve(url)
    event.flag # STATELESS
    event.payload.account.status # SUSPENDED
    event.type # SUBSCRIPTION_NOTICE

## Contributing

1. Fork it ( https://github.com/[my-github-username]/appdirect/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
