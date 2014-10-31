module AppDirect
 module Util

    def self.object_classes
      @object_classes ||= {
        :event => Event
      }
    end

    def self.symbolize_names(object)
      case object
      when Hash
        new = {}
        object.each do |key, value|
          key = (key.to_sym rescue key) || key
          new[key] = symbolize_names(value)
        end
        new
      when Array
        object.map { |value| symbolize_names(value) }
      else
        object
      end
    end

     def self.convert_to_appdirect_object(resp, consumer_key, secret)
      case resp
      when Array
        resp.map { |i| convert_to_appdirect_object(i, consumer_key, secret) }
      when Hash
        # Try converting to a known object class.  If none available, fall back to generic BoffinIOObject
        object_classes.fetch(resp.keys.first, AppDirectObject).construct_from(resp, consumer_key, secret)
      else
        resp
      end
    end
end
end