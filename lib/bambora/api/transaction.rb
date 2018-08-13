module Bambora::API
  class Transaction
    include ResponseHelpers
    include HashHelpers

    attr_accessor :id, :authorizing_merchant_id, :approved, :message_id,
                  :message, :auth_code, :created, :amount, :order_number, :type,
                  :comments, :batch_number, :total_refunds, :total_completions,
                  :payment_method, :card, :billing, :shipping, :custom,
                  :adjusted_by, :links


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
      self.amount = args[:amount]
      self.order_number = args[:order_number]
      self.type = args[:type]
      self.comments = args[:comments]
      self.batch_number = args[:batch_number]
      self.total_refunds = args[:total_refunds]
      self.total_completions = args[:total_completions]
      self.payment_method = args[:payment_method]
      self.card = CardResponse.new(args[:card])
      self.billing = Address.new(args[:billing])
      self.shipping = Address.new(args[:shipping])
      self.custom = Custom.new(args[:custom])
      self.adjusted_by = args[:adjusted_by]
      self.links = args[:links]
    end

    def to_h
      {
        id: id,
        authorizing_merchant_id: authorizing_merchant_id,
        approved: approved,
        message_id: message_id,
        message: message,
        auth_code: auth_code,
        created: created,
        amount: amount,
        order_number: order_number,
        type: type,
        comments: comments,
        batch_number: batch_number,
        total_refunds: total_refunds,
        total_completions: total_completions,
        payment_method: payment_method,
        card: card,
        billing: billing,
        shipping: shipping,
        custom: custom,
        adjusted_by: adjusted_by,
        links: links
      }
    end

    def to_json
      to_h.to_json
    end

  end
end
