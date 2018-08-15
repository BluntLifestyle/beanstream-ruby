module Bambora::API
  class Profile
    extend Authorization
    include APIHelpers

    self.merchant_id = -> { Bambora.merchant_id }
    self.passcode = -> { Bambora.profiles_api_key }

    def self.create(data = {})

    end

    def self.get(data = {})

    end

    def self.delete(data = {})

    end

    def self.update(data = {})

    end

    private

      def profile_url
        uri = URI(Bambora.api_base_url)
        uri.path += '/profiles'
        uri
      end

      def profile_cards_url
        uri = URI(Bambora.api_base_url)
        uri.path += "/profiles/cards"
        uri
      end

	end
end
