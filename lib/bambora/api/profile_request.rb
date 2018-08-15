module Bambora::API
  class ProfileRequest

    attr_accessor :card, :token, :billing, :custom, :language, :comment, :validate

    def initialize(args = {})
      args = {} if args.nil?
      args.symbolize_keys!
      self.card = Card.new(args[:card]) unless args[:card].nil?
      self.token = args[:token] unless args[:token].nil?
      self.billing = Address.new(args[:billing]) unless args[:billing].nil?
      self.custom = Custom.new(args[:custom]) unless args[:custom].nil?
      self.validate = args[:validate]
    end

    def to_h
      {
        
      }
    end

    def to_json
      to_h.to_json
    end
  end
end
