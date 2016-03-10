module Attributor
  class String
    include Type

    def self.native_type
      return ::String
    end

    def self.load(value,context=Attributor::DEFAULT_ROOT_CONTEXT, **options)
      if value.kind_of?(Enumerable)
        raise IncompatibleTypeError,  context: context, value_type: value.class, type: self
      end

      value && String(value)
    rescue
      super
    end

    def self.example(context=nil, options:{})
      if options[:regexp]
        begin
          # It may fail to generate an example, see bug #72.
          options[:regexp].gen
        rescue => e
          'Failed to generate example for %s : %s' % [ options[:regexp].inspect, e.message]
        end
      else
        /\w+/.gen
      end
    end

    def self.family
      'string'
    end

    def self.json_schema_type
      :string
    end

  end
end
