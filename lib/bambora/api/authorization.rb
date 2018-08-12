require 'base64'

module Bambora::API
  module Authorization
    def merchant_id
      @@merchant_id
    end

    def merchant_id=(merchant_id)
      @@merchant_id = merchant_id
    end

    def passcode
      @@passcode
    end

    def passcode=(passcode)
      @@passcode = passcode
    end

    def encoded_passcode
      str = [merchant_id.call, passcode.call].join(':')
      Base64.encode64(str).strip
    end
  end
end
