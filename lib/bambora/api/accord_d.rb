module Bambora::API
  class AccordD
    attr_accessor :financing_type, :plan_number, :grace_period, :term

    def initialize(args)
      args = {} if args.nil?
      self.financing_type = args[:financing_type] || ''
      self.plan_number = args[:plan_number] || ''
      self.grace_period = args[:grace_period] || ''
      self.term = args[:term] || ''
    end

    def to_h
      {
        financing_type: financing_type,
        plan_number: plan_number,
        grace_period: grace_period,
        term: term
      }
    end

    def empty?
      [ :financing_type, :plan_number, :grace_period, :term ].each do |attribute|
        return false unless self.send(attribute).empty?
      end
      return true
    end
  end
end
