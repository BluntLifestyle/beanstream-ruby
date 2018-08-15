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

    def declined?
      return true if message == 'DECLINE'
      false
    end

    def approved?
      false
    end

  end
end
