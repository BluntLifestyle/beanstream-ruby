module Bambora::API
  class Address

    attr_accessor :name, :address_line1, :address_line2, :city, :province,
                  :country, :postal_code, :phone_number, :email_address

    def initialize(args = {})
      args = {} if args.nil?
      self.name = args[:name] || ''
      self.address_line1 = args[:address_line1] || ''
      self.address_line2 = args[:address_line2] || ''
      self.city = args[:city] || ''
      self.province = args[:province] || ''
      self.country = args[:country] || ''
      self.postal_code = args[:postal_code] || ''
      self.phone_number = args[:phone_number] || ''
      self.email_address = args[:email_address] || ''
    end

    def to_h
      {
        name: name,
        address_line1: address_line1,
        address_line2: address_line2,
        city: city,
        province: province,
        country: country,
        postal_code: postal_code,
        phone_number: phone_number,
        email_address: email_address
      }
    end

    def empty?
      [ :name, :address_line1, :address_line2, :city, :province, :country,
        :postal_code, :phone_number, :email_address ].each do |attribute|
          return false unless self.send(attribute).empty?
      end
      return true
    end
  end
end
