module Bambora::API
  class Token

    def self.create(data = {})
      if data.kind_of? TokenRequest
        request = data
      elsif data.kind_of?(Hash) || data.kind_of?(Card)
        request = TokenRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(create_url.to_s, request.to_json, {})
        if response.code == 200
          response = TokenResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    private

      # NOTE: the full URL is different for tokens (it doesn't have a version)
      def self.create_url
        uri = URI(Bambora.api_base_url)
        uri.path = '/scripts/tokenization/tokens'
        uri
      end

  end
end
