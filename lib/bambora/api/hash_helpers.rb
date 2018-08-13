module Bambora::API
  module HashHelpers
    def symbolize_keys(h)
      h.keys.each do |key|
        h[(key.to_sym rescue key) || key] = h.delete(key)
      end
    end
  end
end
