require 'bigdecimal'

module Attributor

  class BigDecimal < Numeric

    def self.native_type
      return ::BigDecimal
    end

    def self.example(context=nil, **options)
      return ::BigDecimal.new("#{/\d{3}/.gen}.#{/\d{3}/.gen}")
    end

    def self.load(value,context=Attributor::DEFAULT_ROOT_CONTEXT, **options)
      return nil if value.nil?
      return value if value.is_a?(self.native_type)
      if value.kind_of?(::Float)
        return BigDecimal(value, 10)
      end
      return BigDecimal(value)
    end

    def self.json_schema_type
      :number
    end

  end

end

