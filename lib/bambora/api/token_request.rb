module Bambora::API
  class TokenRequest

    attr_accessor :name, :number, :expiry_month, :expiry_year, :cvd

    def initialize(args = {})
      if args.kind_of? Card
        self.name = args.name
        self.number = args.number
        self.expiry_month = args.expiry_month
        self.expiry_year = args.expiry_year
        self.cvd = args.cvd
      else
        args = {} if args.nil?
        args.symbolize_keys!
        self.name = args[:name]
        self.number = args[:number]
        self.expiry_month = args[:expiry_month]
        self.expiry_year = args[:expiry_year]
        self.cvd = args[:cvd]
      end
    end

    def to_h
      {
        number: number,
        expiry_month: expiry_month,
        expiry_year: expiry_year,
        cvd: cvd
      }
    end

    def to_json
      to_h.to_json
    end
  end
end
