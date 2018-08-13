module Bambora::API
  class ErrorResponse
    attr_accessor :code, :category, :message, :reference, :details, :validation

    def initialize(args = {})
      args = {} if args.nil?
      if args.respond_to? :symbolize_keys!
        args.symbolize_keys!
      else
        symbolize_keys(args)
      end
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

    private

      def symbolize_keys(h)
        h.keys.each do |key|
          h[(key.to_sym rescue key) || key] = h.delete(key)
        end
      end

  end
end
