module Bambora::API
  class ProfileResponse
    attr_accessor :code, :message, :customer_code, :validation

    def initialize(args = {})
      args = {} if args.nil?
      args.symbolize_keys!
      self.code = args[:code]
      self.message = args[:message]
      self.customer_code = args[:customer_code]
      self.validation = args[:validation]
    end

    def to_h
      {
        code: code,
        message: message,
        customer_code: customer_code,
        validation: validation
      }
    end

    def to_json
      to_h.to_json
    end
  end
end
