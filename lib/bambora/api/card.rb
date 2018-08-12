module Bambora::API
  class Card

    attr_accessor :number, :name, :expiry_month, :expiry_year, :cvd,
                  :_3d_secure, :masterpass_wallet_id, :visa_checkout_call_id,
                  :is_accord_d, :accord_d

    alias_method :is_accord_d?, :is_accord_d

    def initialize(args = {})
      args = {} if args.nil?
      self.number = args[:number] || ''
      self.name = args[:name] || ''
      self.expiry_month = args[:expiry_month] || ''
      self.expiry_year = args[:expiry_year] || ''
      self.cvd = args[:cvd]
      self._3d_secure = Secure3D.new(args[:'3d_secure'])
      self.masterpass_wallet_id = args[:masterpass_wallet_id]
      self.visa_checkout_call_id = args[:visa_checkout_call_id]
      self.is_accord_d = args[:is_accord_d] || false
      self.accord_d = AccordD.new(args[:accord_d])
    end

    def to_h
      h = {
        number: number,
        name: name,
        expiry_month: expiry_month,
        expiry_year: expiry_year
      }
      h.merge!(cvd: cvd) unless cvd.empty?
      h.merge!('3d_secure': _3d_secure.to_h) unless _3d_secure.empty?
      h.merge!(masterpass_wallet_id: masterpass_wallet_id) unless masterpass_wallet_id.nil?
      h.merge!(visa_checkout_call_id: visa_checkout_call_id) unless visa_checkout_call_id.nil?
      h.merge!(is_accord_d: is_accord_d, accord_d: accord_d) if is_accord_d?
      h
    end
  end
end
