module Bambora::API

  class SearchRequest
    include HashHelpers

    attr_accessor :name, :start_date, :end_date, :start_row, :end_row, :criteria

    def initialize(args = {})
      args = {} if args.nil?
      if args.respond_to? :symbolize_keys!
        args.symbolize_keys!
      else
        symbolize_keys(args)
      end
      self.name = args[:name]
      self.start_date = args[:start_date]
      self.end_date = args[:end_date]
      self.start_row = args[:start_row]
      self.end_row = args[:end_row]
      self.criteria = args[:criteria]
    end

    def to_h
      h = {
        name: name,
        start_date: start_date,
        end_date: end_date,
        start_row: start_row,
        end_row: end_row
      }
      h.merge!(criteria: criteria) unless criteria.nil?
      h
    end

    def to_json
      to_h.to_json
    end

  end
end
