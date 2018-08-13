
#     def search_transactions(start_date, end_date, start_row, end_row, criteria=nil)
#       if !start_date.is_a?(Time)
#         raise InvalidRequestException.new(0, 0, "start_date must be of type Time in ReportingApi.search_transactions", 0)
#       end
#       if !end_date.is_a?(Time)
#         raise InvalidRequestException.new(0, 0, "end_date must be of type Time in ReportingApi.search_transactions", 0)
#       end
#       if criteria != nil && !criteria.kind_of?(Array) && !criteria.is_a?(Bambora::Criteria)
#         puts "criteria was of type: #{criteria.class}"
#         raise InvalidRequestException.new(0, 0, "criteria must be of type Array<Critiera> or Criteria in ReportingApi.search_transactions", 0)
#       end
#       if criteria.is_a?(Bambora::Criteria)
#         #make it an array
#         criteria = Array[criteria]
#       end
#
#       startD = start_date.strftime "%Y-%m-%dT%H:%M:%S"
#       endD = end_date.strftime "%Y-%m-%dT%H:%M:%S"
#
#       criterias = Array[]
#       if criteria != nil && criteria.length > 0
#         for c in criteria
#           criterias << c.to_hash
#         end
#       end
#       query = {
#         "name" => "Search",
#         "start_date" => startD,
#         "end_date" => endD,
#         "start_row" => start_row,
#         "end_row" => end_row,
#         "criteria" => criterias
#       }
#       puts "\n\nReport search query #{query}\n\n"
#       val = transaction_post("POST", reports_url, Bambora.merchant_id, Bambora.reporting_api_key, query)
#       results = val['records']
#     end

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
