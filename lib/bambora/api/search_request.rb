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
      self.name = args[:name] || 'Search'
      self.start_date = Chronic.parse(args[:start_date]) || Time.now.beginning_of_day
      self.end_date = Chronic.parse(args[:end_date]) || start_date.end_of_day
      self.start_row = args[:start_row] || 1
      self.end_row = args[:end_row] || start_row + 1
      self.criteria = build_criterias(args[:criteria])
    end

    def to_h
      h = {
        name: name,
        start_date: start_date.strftime('%Y-%m-%dT%H:%M:%S'),
        end_date: end_date.strftime('%Y-%m-%dT%H:%M:%S'),
        start_row: start_row,
        end_row: end_row
      }
      h.merge!(criteria: criteria.map(&:to_h)) unless criteria.nil?
      h
    end

    def to_json
      to_h.to_json
    end

    private

    def build_criterias(elements)
      return [Criteria.new(elements)] if elements.kind_of? Criteria
      ary = []
      elements.each do |element|
        ary << Criteria.new(element)
      end
      ary
    end

  end
end
