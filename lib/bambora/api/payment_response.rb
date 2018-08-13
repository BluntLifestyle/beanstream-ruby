module Bambora::API
  class PaymentResponse

    attr_accessor :id, :authorizing_merchant_id, :approved, :message_id,
                  :message, :auth_code, :created, :order_number, :type,
                  :risk_score, :amount, :payment_method, :custom, :card,
                  :merchant_data, :contents, :interac_online, :links

    def initialize(args = {})
      args = {} if args.nil?
      if args.respond_to? :symbolize_keys!
        args.symbolize_keys!
      else
        symbolize_keys(args)
      end
      self.id = args[:id]
      self.authorizing_merchant_id = args[:authorizing_merchant_id]
      self.approved = args[:approved]
      self.message_id = args[:message_id]
      self.message = args[:message]
      self.auth_code = args[:auth_code]
      self.created = args[:created]
      self.order_number = args[:order_number]
      self.type = args[:type]
      self.risk_score = args[:risk_score]
      self.amount = args[:amount]
      self.payment_method = args[:payment_method]
      self.custom = args[:custom]
      self.card = args[:card]
      self.merchant_data = args[:merchant_data]
      self.contents = args[:contents]
      self.interac_online = args[:interac_online]
      self.links = args[:links]
    end

    def to_h
      {
        authorizing_merchant_id: authorizing_merchant_id,
        approved: approved,
        message_id: message_id,
        message: message,
        auth_code: auth_code,
        created: created,
        order_number: order_number,
        type: type,
        risk_score: risk_score,
        amount: amount,
        payment_method: payment_method,
        custom: custom,
        card: card,
        merchant_data: merchant_data,
        contents: contents,
        interac_online: interac_online,
        links: links
      }
    end

    def approved?
      return false if approved == 0
      true
    end

    private

      def symbolize_keys(h)
        h.keys.each do |key|
          h[(key.to_sym rescue key) || key] = h.delete(key)
        end
      end

  end
end
