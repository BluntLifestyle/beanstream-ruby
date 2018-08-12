require 'securerandom'
require 'rest-client'

module Bambora::API

  # class PaymentMethods
  #   CARD = "card"
  #   CASH = "cash"
  #   CHEQUE = "cheque"
  #   TOKEN = "token"
  #   PROFILE = "payment_profile"
  # end
  #
  # class Payments < Transaction
  #
  #   def self.generateRandomOrderId(prefix)
  #     "#{prefix}_#{SecureRandom.hex(8)}"
  #   end
  #
  #
  #   # Urls
  #

  #
  #   def payment_returns_url(transaction_id)
  #     uri = URI(Bambora.api_base_url)
  #     uri.path += "/payments/#{transaction_id}/returns"
  #     uri
  #   end
  #
  #   def payment_void_url(transaction_id)
  #     uri = URI(Bambora.api_base_url)
  #     uri.path += "/payments/#{transaction_id}/void"
  #     uri
  #   end
  #
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
  #   def complete_preauth(transaciton_id, amount)
  #     complete_url = make_payment_url+transaciton_id+"/completions"
  #     completion = { :amount => amount }
  #     val = post("POST", complete_url, Bambora.merchant_id, Bambora.payments_api_key, completion)
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
  #
  #   def get_transaction(transaction_id)
  #     post("GET", get_transaction_url(transaction_id), Bambora.merchant_id, Bambora.payments_api_key)
  #   end
  #
  #   def return_payment(transaction_id, amount)
  #     data = { amount: amount }
  #     post("POST", payment_returns_url(transaction_id), Bambora.merchant_id, Bambora.payments_api_key, data)
  #   end
  #
  #   def void_payment(transaction_id, amount)
  #     data = { amount: amount }
  #     post("POST", payment_void_url(transaction_id), Bambora.merchant_id, Bambora.payments_api_key, data)
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
        raise UnsupportedOptionError, "`#{opts}` is not supported"
      end

      begin
        response = RestClient.post(create_url.to_s, request.to_json, {"Authorization": "Passcode #{encoded_passcode}", "Content-Type": "application/json" })
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

    def self.return(transaction_id)
      RestClient.post()
    end

    def self.void(transaction_id)
    end

    def self.completion(transaction_id)
    end

    def self.get(transaction_id)
    end

    private

      def self.create_url
        uri = URI(Bambora.api_base_url)
        uri.path += '/payments'
        uri
      end

  end

end
