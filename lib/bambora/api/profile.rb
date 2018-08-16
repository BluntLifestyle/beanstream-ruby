module Bambora::API
  class Profile
    extend Authorization
    include APIHelpers

    self.merchant_id = -> { Bambora.merchant_id }
    self.passcode = -> { Bambora.profiles_api_key }

    attr_accessor :id, :name

    def initialize(args = {})
      if args.kind_of? ProfileResponse
        self.id = args.customer_code
      else
        args = {} if args.nil?
        args.symbolize_keys!
        self.id = args[:id]
        self.name = args[:name]
      end
    end

    def self.create(data = {})
      if data.kind_of? ProfileRequest
        request = data
      elsif data.kind_of?(Hash) || data.kind_of?(Token)
        request = ProfileRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(create_url.to_s, request.to_json, headers)
        if response.code == 200
          response = ProfileResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      new(id: response.customer_code, name: fetch_name(data))
    end

    # TODO
    def self.get(data = {})
      raise "not yet implemented"
    end

    # TODO
    def self.delete(data = {})
      raise "not yet implemented"
    end

    # TODO
    def self.update(data = {})
      raise "not yet implemented"
    end

    private

      def self.fetch_name(data)
        return data.name if data.respond_to?(:name)

        if data.respond_to?(:card)
          if data.card.respond_to?(:name)
            return data.card.name
          end
        end

        if data.kind_of? Hash
          if data.has_key? :name
            return data[:name]
          elsif data.has_key? :card
            if data[:card].has_key? :name
              return data[:card][:name]
            end
          end
        end

        ''
      end

      def self.create_url
        uri = URI(Bambora.api_base_url)
        uri.path += '/profiles'
        uri
      end

      def self.profile_cards_url
        uri = URI(Bambora.api_base_url)
        uri.path += "/profiles/cards"
        uri
      end

	end
end
