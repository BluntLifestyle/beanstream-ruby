module Bambora::API
  class ProfileRequest

    attr_accessor :card, :token, :billing, :custom, :language, :comment, :validate

    def initialize(args = {})
      if args.kind_of? Token
        self.token = args
      else
        args = {} if args.nil?
        args.symbolize_keys!
        self.card = Card.new(args[:card]) unless args[:card].nil?
        self.token = Token.new(args[:token]) unless args[:token].nil?
        self.billing = Address.new(args[:billing]) unless args[:billing].nil?
        self.custom = Custom.new(args[:custom]) unless args[:custom].nil?
        self.validate = args[:validate]
      end
    end

    def to_h
      h = { billing: billing, validate: validate }
      h.merge!( card: card.to_h ) unless card.nil?
      h.merge!( token: (token.kind_of?(Token) ? token.to_h : token) ) unless token.nil?
      h.merge!( custom: custom.to_h ) unless custom.nil?
      h
    end

    def to_json
      to_h.to_json
    end
  end
end
