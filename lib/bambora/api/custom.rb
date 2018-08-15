module Bambora::API
  class Custom

    attr_accessor :ref1, :ref2, :ref3, :ref4, :ref5

    def initialize(args = {})
      args = {} if args.nil?
      args.symbolize_keys!
      self.ref1 = args[:ref1] || ''
      self.ref2 = args[:ref2] || ''
      self.ref3 = args[:ref3] || ''
      self.ref4 = args[:ref4] || ''
      self.ref5 = args[:ref5] || ''
    end

    def to_h
      {
        ref1: ref1,
        ref2: ref2,
        ref3: ref3,
        ref4: ref4,
        ref5: ref5
      }
    end

    def empty?
      [ :ref1, :ref2, :ref3, :ref4, :ref5 ].each do |attribute|
        return false unless self.send(attribute).empty?
      end
      return true
    end
  end
end
