require 'securerandom'
require 'rest-client'

module Bambora::API

  # class Payments < Transaction
  #
  #   def self.generateRandomOrderId(prefix)
  #     "#{prefix}_#{SecureRandom.hex(8)}"
  #   end

  #   def get_transaction_url(transaction_id)
  #     uri = URI(Bambora.api_base_url)
  #     uri.path += "/payments/#{transaction_id}"
  #     uri
  #   end
  #
  #   #Payment Request Hash for making a payment with a Legato token
  #   def getTokenPaymentRequestTemplate()
  #     request = template
  #     request[:payment_method] = PaymentMethods::TOKEN
  #     request[:token] = {
  #       :name => "",
  #       :code => "",
  #       :complete => true
  #     }
  #     return request
  #   end
  #
  #   #Payment Request Hash for making a payment with a credit card number
  #   def getCardPaymentRequestTemplate()
  #     request = template
  #     request[:payment_method] = PaymentMethods::CARD
  #     request[:card] = {
  #       :name => "",
  #       :number => "",
  #       :expiry_month => "",
  #       :expiry_year => "",
  #       :cvd => "",
  #       :complete => true
  #      }
  #      return request
  #   end
  #
  #   #Payment Request Hash for making a payment with a Payment Profile
  #   def getProfilePaymentRequestTemplate()
  #     request = template
  #     request[:payment_method] = PaymentMethods::PROFILE
  #     request[:payment_profile] = {
  #       :customer_code => "",
  #       :card_id => 1,
  #       :complete => true
  #     }
  #     return request
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

    self.merchant_id = -> { Bambora.merchant_id }
    self.passcode = -> { Bambora.payments_api_key }

    def self.create(opts = {})
      if opts.kind_of? PaymentRequest
        request = opts
      elsif opts.kind_of? Hash
        request = PaymentRequest.new(opts)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{opts}` is not supported"
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
    def self.preauth(opts = {})
      opts[opts[:payment_method]].merge!(complete: false)
      create(opts)
    end

    def self.return(transaction_id, opts = {})
      if opts.kind_of? ReturnRequest
        request = opts
      elsif opts.kind_of? Hash
        request = ReturnRequest.new(opts)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{opts}` is not supported"
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

    def self.void(transaction_id, opts = {})
      if opts.kind_of? VoidRequest
        request = opts
      elsif opts.kind_of? Hash
        request = VoidRequest.new(opts)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{opts}` is not supported"
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

    def self.completion(transaction_id, opts)
      if opts.kind_of? PaymentRequest
        request = opts
      elsif opts.kind_of? Hash
        request = PaymentRequest.new(opts)
      else
        raise ::Bambora::UnsupportedOptionError, "`#{opts}` is not supported"
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

    def self.continue(merchant_data)

    end

    private

      def self.headers
        {
          "Authorization": "Passcode #{encoded_passcode}",
          "Content-Type": "application/json"
        }
      end

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

  end

end
