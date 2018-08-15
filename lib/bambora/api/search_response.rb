module Bambora::API
  class SearchResponse
    
    attr_accessor :records

    def initialize(args = {})
      args = {} if args.nil?
      args.symbolize_keys!
      self.records = build_search_records(args[:records])
    end

    def to_h
      {
        records: records.map(&:to_h)
      }
    end

    def to_json
      to_h.to_json
    end

    private

      def build_search_records(elements)
        ary = []
        elements.each do |element|
          ary << SearchRecord.new(element)
        end
        ary
      end

  end
end
