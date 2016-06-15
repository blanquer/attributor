# Abstract type for the 'temporal' family

module Attributor

  class Temporal
    include Type

    def self.native_type
      raise NotImplementedError
    end

    def self.family
      'temporal'
    end

    def self.dump(value,**opts)
      value && value.iso8601
    end

    def self.json_schema_type
      :string
    end

    def self.as_json_schema( shallow: false, example: nil, attribute_options: {} )
      h = super
      opts = ( self.respond_to?(:options) ) ? self.options.merge( attribute_options ) : attribute_options
      h
    end

  end
end
