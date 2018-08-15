module Bambora::API
  class Report
    extend Authorization
    include APIHelpers

    self.merchant_id = -> { Bambora.merchant_id }
    self.passcode = -> { Bambora.reporting_api_key }

    def self.search(data = {})
      if data.kind_of? SearchRequest
        request = data
      elsif data.kind_of? Hash
        request = SearchRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(search_url.to_s, request.to_json, headers)
        if response.code == 200
          response = SearchResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    # convenience method for minimal search
    # TODO: confirm how/if this should work
    def self.minimal(data = {})
      data.merge!(name: 'TransHistoryMinimal')
      search(data)
    end

    private

      def self.search_url
        uri = URI(Bambora.api_base_url)
        uri.path += '/reports'
        uri
      end

  end
end
