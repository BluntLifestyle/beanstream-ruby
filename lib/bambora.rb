module Bambora
  autoload :BamboraError,                  'bambora/bambora_error'
  autoload :UnsupportedPaymentMethodError, 'bambora/bambora_error'
  autoload :UnsupportedOptionError,        'bambora/bambora_error'
  module API
    autoload :AccordD,                     'bambora/api/accord_d'
    autoload :Address,                     'bambora/api/address'
    autoload :Authorization,               'bambora/api/authorization'
    autoload :Card,                        'bambora/api/card'
    autoload :Custom,                      'bambora/api/custom'
    autoload :ErrorResponse,               'bambora/api/error_response'
    autoload :PaymentRequest,              'bambora/api/payment_request'
    autoload :PaymentResponse,             'bambora/api/payment_response'
    autoload :Payment,                     'bambora/api/payment'
    autoload :Profiles,                    'bambora/api/profiles'
    autoload :Reporting,                   'bambora/api/reporting'
    autoload :ReturnRequest,               'bambora/api/return_request'
    autoload :Secure3D,                    'bambora/api/secure_3d'
    autoload :Transaction,                 'bambora/api/transaction'
  end

  @host = "https://api.na.bambora.com"
  @version = "v1"

  # @ssl_ca_cert = File.dirname(__FILE__) + '/resources/cacert.pem'
  # @timeout = 80
  # @open_timeout = 40

  class << self
    attr_accessor :merchant_id, :payments_api_key, :profiles_api_key, :reporting_api_key
    # attr_accessor :url_prefix, :url_base, :url_suffix, :url_version
    # attr_accessor :url_host
    # attr_accessor :url_payments, :url_return, :url_void
    # attr_accessor :ssl_ca_cert, :timeout, :open_timeout
  end

  def self.api_host_url
    URI(@host)
  end

  def self.api_base_url
    uri = URI(@host)
    uri.path += ['/', @version].join
    uri
  end
end


# public test id ?
# def run()
#   Bambora.merchant_id = "300200578"
#   Bambora.payments_api_key = "4BaD82D9197b4cc4b70a221911eE9f70"
#   result = Bambora.PaymentsAPI().make_creditcard_payment(12.5)
#   puts "Payment result: #{result}"
# end
