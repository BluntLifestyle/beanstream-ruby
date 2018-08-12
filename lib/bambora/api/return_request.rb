module Bambora::API
  class ReturnRequest
    attr_accessor :order_number, :amount

    def initialize(args = {})
      args = {} if args.nil?
      self.order_number = args[:order_number] || ''
      self.amount = args[:amount] || 0.0
    end

    def to_h
      h = { amount: amount }
      h.merge!(order_number: order_number) unless order_number.empty?
      h
    end

    def to_json
      to_h.to_json
    end
  end
end
