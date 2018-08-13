module Bambora::API
  class ContinueRequest
    include HashHelpers

    attr_accessor :payment_method, :card_response, :interac_response

    def initialize(args = {})
      args = {} if args.nil?
      if args.respond_to? :symbolize_keys!
        args.symbolize_keys!
      else
        symbolize_keys(args)
      end
      self.payment_method = args[:payment_method].to_sym
      self.card_response = CardResponse.new(args[:card_response])
      self.interac_response = InteracResponse.new(args[:interac_response])
    end

    def to_h
      h = { payment_method: payment_method }
      case payment_method.to_sym
      when :card
        h.merge!(card_response: card_response.to_h)
      when :interac
        h.merge!(interac_response: interac_response.to_h)
      else
        raise Bambora::UnsupportedPaymentMethodError, "Payment method `#{payment_method}` is not supported"
      end
      h
    end

    def to_json
      to_h.to_json
    end

  end
end
