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
      id = merchant_id.respond_to?(:call) ? merchant_id.call : merchant_id
      pass = passcode.respond_to?(:call) ? passcode.call : passcode
      str = [id, pass].join(':')
      Base64.encode64(str).strip
    end
  end
end
