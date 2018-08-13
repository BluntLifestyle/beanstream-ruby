module Bambora::API
  module APIHelpers

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def headers
        {
          "Authorization": "Passcode #{encoded_passcode}",
          "Content-Type": "application/json"
        }
      end
    end

  end
end
