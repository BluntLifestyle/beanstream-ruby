require 'base64'
require 'date'
require 'json'
require 'active_support/all'
require 'chronic'
require 'rest-client'
require 'cgi'
require 'securerandom'

module Bambora
  autoload :BamboraError,                  'bambora/bambora_error'
  autoload :UnsupportedPaymentMethodError, 'bambora/bambora_error'
  autoload :UnsupportedOptionError,        'bambora/bambora_error'
  module API
    autoload :AccordD,                     'bambora/api/accord_d'
    autoload :Address,                     'bambora/api/address'
    autoload :APIHelpers,                  'bambora/api/api_helpers'
    autoload :Authorization,               'bambora/api/authorization'
    autoload :CardResponse,                'bambora/api/card_response'
    autoload :Card,                        'bambora/api/card'
    autoload :ContinueRequest,             'bambora/api/continue_request'
    autoload :Criteria,                    'bambora/api/criteria'
    autoload :Custom,                      'bambora/api/custom'
    autoload :ErrorResponse,               'bambora/api/error_response'
    autoload :PaymentRequest,              'bambora/api/payment_request'
    autoload :PaymentResponse,             'bambora/api/payment_response'
    autoload :Payment,                     'bambora/api/payment'
    autoload :ProfileRequest,              'bambora/api/profile_request'
    autoload :ProfileResponse,             'bambora/api/profile_response'
    autoload :Profile,                     'bambora/api/profile'
    autoload :Report,                      'bambora/api/report'
    autoload :ResponseHelpers,             'bambora/api/response_helpers'
    autoload :ReturnRequest,               'bambora/api/return_request'
    autoload :SearchRecord,                'bambora/api/search_record'
    autoload :SearchRequest,               'bambora/api/search_request'
    autoload :SearchResponse,              'bambora/api/search_response'
    autoload :Secure3D,                    'bambora/api/secure_3d'
    autoload :TokenRequest,                'bambora/api/token_request'
    autoload :TokenResponse,               'bambora/api/token_response'
    autoload :Token,                       'bambora/api/token'
    autoload :Transaction,                 'bambora/api/transaction'
    autoload :VoidRequest,                 'bambora/api/void_request'
  end

  @host = "https://api.na.bambora.com"
  @version = "v1"

  class << self
    attr_accessor :merchant_id, :payments_api_key, :profiles_api_key, :reporting_api_key
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
