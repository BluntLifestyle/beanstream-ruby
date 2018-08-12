module Bambora::API
  class PaymentRequest

    attr_accessor :order_number, :amount, :payment_method, :language,
                  :customer_ip, :term_url, :comments, :billing, :shipping,
                  :custom, :card

    def initialize(args = {})
      args = {} if args.nil?
      self.order_number = args[:order_number] || ''
      self.amount = args[:amount]
      self.payment_method = args[:payment_method]
      self.language = args[:language] || ''
      self.customer_ip = args[:customer_ip] || ''
      self.term_url = args[:term_url] || ''
      self.comments = args[:comments] || ''
      self.billing = Address.new(args[:billing])
      self.shipping = Address.new(args[:shipping])
      self.custom = Custom.new(args[:custom])
      self.card = Card.new(args[:card])
    end

    def to_h
      h = {
        amount: amount,
        payment_method: payment_method
      }
      h.merge!(customer_ip: customer_ip) unless customer_ip.empty?
      h.merge!(term_url: term_url) unless term_url.empty?
      h.merge!(comments: comments) unless comments.empty?
      h.merge!(order_number: order_number) unless order_number.empty?
      h.merge!(language: language) unless language.empty?
      h.merge!(billing: billing.to_h) unless billing.empty?
      h.merge!(shipping: shipping.to_h,) unless shipping.empty?
      h.merge!(custom: custom.to_h) unless custom.empty?
      if respond_to?(payment_method)
        h.merge!(payment_method => self.send(payment_method).to_h)
      else
        raise UnsupportedPaymentMethodError, "Payment method `#{payment_method}` is not currently supported."
      end
      h
    end

    def to_json
      to_h.to_json
    end

  end
end
