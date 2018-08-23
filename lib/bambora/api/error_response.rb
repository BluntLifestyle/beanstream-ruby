module Bambora::API
  class ErrorResponse

    attr_accessor :code, :category, :message, :reference, :details, :validation

    def initialize(args = {})
      args = {} if args.nil?
      args.symbolize_keys!
      self.code = args[:code]
      self.category = args[:category]
      self.message = args[:message]
      self.reference = args[:reference]
      self.details = args[:details]
      self.validation = args[:validation]
    end

    def to_h
      {
        code: code,
        category: category,
        message: message,
        reference: reference,
        details: details,
        validation: validation
      }
    end

    def to_json
      to_h.to_json
    end

    def declined?
      true
    end

    def approved?
      false
    end

  end
end
