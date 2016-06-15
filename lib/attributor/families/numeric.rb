# Abstract type for the 'numeric' family

module Attributor

  class Numeric
    include Type

    def self.native_type
      raise NotImplementedError
    end

    def self.family
      'numeric'
    end

    def self.json_schema_type
      :number
    end

    def self.as_json_schema( shallow: false, example: nil, attribute_options: {} )
      h = super
      opts = ( self.respond_to?(:options) ) ? self.options.merge( attribute_options ) : attribute_options
      h[:minimum] = opts[:min] if opts[:min]
      h[:maximum] = opts[:max] if opts[:max]
      # TODO: exclusiveMinimum and exclusiveMaximum
      h
    end

  end
end
