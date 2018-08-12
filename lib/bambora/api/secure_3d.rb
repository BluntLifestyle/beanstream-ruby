module Bambora::API
  class Secure3D
    attr_accessor :enabled, :xid, :cavv, :eci

    def initialize(args = {})
      args = {} if args.nil?
      self.enabled = args[:enabled] || false
      self.xid = args[:xid] || ''
      self.cavv = args[:cavv] || ''
      self.eci = args[:eci] || ''
    end

    def to_h
      {
        enabled: enabled,
        xid: xid,
        cavv: cavv,
        eci: eci
      }
    end

    def empty?
      [ :xid, :cavv, :eci ].each do |attribute|
          return false unless self.send(attribute).empty?
      end
      return true && !enabled
    end
  end
end
