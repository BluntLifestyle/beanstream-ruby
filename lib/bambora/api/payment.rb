module Bambora::API

  #   def self.generateRandomOrderId(prefix)
  #     "#{prefix}_#{SecureRandom.hex(8)}"
  #   end

  #   #API operations
  #
  #   # Make a payment. If the payment is approved the PaymentResponse will be returned. If for any reason
  #   # the payment is declined or if there is a connection error an exception will be thrown.
  #   # This will accept a PaymentRequest Hash as defined by getTokenPaymentRequestTemplate(), getCardPaymentRequestTemplate(),
  #   # or getProfilePaymentRequestTemplate().
  #   # +PreAuth+:: For a pre-auth you must set the 'complete' parameter of the Card, Token, or Profile to be 'false'.
  #   def make_payment(payment)
  #     val = post("POST", make_payment_url, Bambora.merchant_id, Bambora.payments_api_key, payment)
  #   end
  #

  #   def self.payment_approved(payment_response)
  #     success = payment_response['approved'] == "1" && payment_response['message'] == "Approved"
  #   end
  #
  #   def get_legato_token(card_info)
  #     turl = "/scripts/tokenization/tokens"
  #     result = Transaction.new().post("POST", turl, "", "", card_info)
  #     token = result['token']
  #   end

  class Payment
    extend Authorization
    include APIHelpers

    self.merchant_id = -> { Bambora.merchant_id }
    self.passcode = -> { Bambora.payments_api_key }

    def self.create(data = {})
      if data.kind_of? PaymentRequest
        request = data
      elsif data.kind_of? Hash
        request = PaymentRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(create_url.to_s, request.to_json, headers)
        if response.code == 200
          response = PaymentResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    # convenience method for preauthorizing payments
    def self.preauth(data = {})
      data[data[:payment_method]].merge!(complete: false)
      create(data)
    end

    def self.return(transaction_id, data = {})
      if data.kind_of? ReturnRequest
        request = data
      elsif data.kind_of? Hash
        request = ReturnRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(return_url(transaction_id).to_s, request.to_json, headers)
        if response.code == 200
          response = PaymentResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    def self.void(transaction_id, data = {})
      if data.kind_of? VoidRequest
        request = data
      elsif data.kind_of? Hash
        request = VoidRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(void_url(transaction_id).to_s, request.to_json, headers)
        if response.code == 200
          response = PaymentResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    def self.completion(transaction_id, data)
      if data.kind_of? PaymentRequest
        request = data
      elsif data.kind_of? Hash
        request = PaymentRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(completion_url(transaction_id).to_s, request.to_json, headers)
        if response.code == 200
          response = PaymentResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    def self.get(transaction_id)
      begin
        response = RestClient.get(get_url(transaction_id).to_s, headers)
        if response.code == 200
          response = Transaction.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    def self.continue(merchant_data, data)
      if data.kind_of? ContinueRequest
        request = data
      elsif data.kind_of? Hash
        request = ContinueRequest.new(data)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{data}` is not supported"
      end

      begin
        response = RestClient.post(continue_url(merchant_data).to_s, request.to_json, headers)
        if response.code == 200
          response = PaymentResponse.new(JSON.parse(response.body))
        else
          raise "request error"
        end
      rescue RestClient::ExceptionWithResponse => e
        response = ErrorResponse.new(JSON.parse(e.response.body))
      end

      response
    end

    private

      def self.create_url
        uri = URI(Bambora.api_base_url)
        uri.path += '/payments'
        uri
      end

      def self.return_url(transaction_id)
        uri = URI(Bambora.api_base_url)
        uri.path += "/payments/#{transaction_id}/returns"
        uri
      end

      def self.void_url(transaction_id)
        uri = URI(Bambora.api_base_url)
        uri.path += "/payments/#{transaction_id}/void"
        uri
      end

      def self.get_url(transaction_id)
        uri = URI(Bambora.api_base_url)
        uri.path += "/payments/#{transaction_id}"
        uri
      end

      def self.completion_url(transaction_id)
        uri = URI(Bambora.api_base_url)
        uri.path += "/payments/#{transaction_id}/completions"
        uri
      end

      def self.continue_url(merchant_data)
        uri = URI(Bambora.api_base_url)
        uri.path += "/payments/#{merchant_data}/continue"
        uri
      end

  end

end
