require 'cgi'

module Bambora::API
  class Criteria

    FIELDS = {
      transaction_id: 1,
      amount: 2,
      masked_card_number: 3,
      card_owner: 4,
      order_number: 5,
      ip_address: 6,
      authorization_code: 7,
      trans_type: 8,
      card_type: 9,
      response: 10,
      billing_name: 11,
      billing_email: 12,
      billing_phone: 13,
      processed_by: 14,
      ref1: 15,
      ref2: 16,
      ref3: 17,
      ref4: 18,
      ref5: 19,
      product_name: 20,
      product_id: 21,
      cust_code: 22,
      id_adjustment_to: 23,
      id_adjusted_by: 24
    }.freeze

    OPERATORS = {
      equals: CGI.escape('='),
      less_than: CGI.escape('<'),
      greater_than: CGI.escape('>'),
      less_than_or_equal: CGI.escape('<='),
      greater_than_or_equal: CGI.escape('>='),
      starts_with: CGI.escape('START_WITH')
    }.freeze

    attr_accessor :field, :operator, :value

    def initialize(args = {})
      args = {} if args.nil?
      args.symbolize_keys!
      self.field = args[:field]
      self.operator = args[:operator]
      self.value = args[:value]
    end

    def to_h
      {
        field: FIELDS[(field.to_sym rescue field)],
        operator: OPERATORS[(operator.to_sym rescue operator)],
        value: value
      }
    end

    def to_json
      to_h.to_json
    end
  end
end
