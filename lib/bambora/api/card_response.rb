module Bambora::API
  class CardResponse
    include HashHelpers
    
    attr_accessor :card_type, :last_four, :cvd_result, :address_match,
                  :avs_result, :expiry_month, :expiry_year, :cavv_result

    def initialize(args = {})
      args = {} if args.nil?
      if args.respond_to? :symbolize_keys!
        args.symbolize_keys!
      else
        symbolize_keys(args)
      end
      self.card_type = args[:card_type]
      self.last_four = args[:last_four]
      self.cvd_result = args[:cvd_result]
      self.address_match = args[:address_match]
      self.avs_result = args[:avs_result]
      self.expiry_month = args[:expiry_month]
      self.expiry_year = args[:expiry_year]
      self.cavv_result = args[:cavv_result]
    end

    def to_h
      {
        card_type: card_type,
        last_four: last_four,
        cvd_result: cvd_result,
        address_match: address_match,
        avs_result: avs_result,
        expiry_month: expiry_month,
        expiry_year: expiry_year,
        cavv_result: cavv_result
      }
    end

    def to_json
      to_h.to_json
    end

  end
end
