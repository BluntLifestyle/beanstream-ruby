module Bambora::API
  class TokenResponse

    attr_accessor :token, :code, :version, :message

    def initialize(args = {})
      args = {} if args.nil?
      args.symbolize_keys!
      self.token = args[:token]
      self.code = args[:code]
      self.version = args[:version]
      self.message = args[:message]
    end

    def to_h
      {
        token: token,
        code: code,
        version: version,
        message: message
      }
    end

    def to_json
      to_h.to_json
    end

  end
end
