module Bambora::API
  class Token
    attr_accessor :name, :code

    def initialize(args = {})
      if args.kind_of? TokenResponse
        self.code = args.token
      else
        args = {} if args.nil?
        args.symbolize_keys!
        self.name = args[:name]
        self.code = args[:code]
      end
    end

    def to_h
      {
        name: name,
        code: code
      }
    end

    def to_json
      to_h.to_json
    end

    def self.create(data = {})
      name = fetch_name(data)
      
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

      new(name: name, code: response.token)
    end

    private

      # NOTE: the full URL is different for tokens (it doesn't have a version)
      def self.create_url
        uri = URI(Bambora.api_base_url)
        uri.path = '/scripts/tokenization/tokens'
        uri
      end

      def self.fetch_name(data)
        return data.name if data.respond_to? :name
        return data.card.name if data.respond_to? :card
        if data.respond_to?(:[])
          if !data[:name].empty?
            return data[:name]
          elsif !data[:card][:name].empty?
            data[:card][:name]
          end
          ''
        else
          ''
        end
      rescue
        ''
      end

  end
end
