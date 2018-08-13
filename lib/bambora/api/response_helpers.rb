module Bambora::API
  module ResponseHelpers
    def approved?
      !(approved == 0)
    end

    def purchased?
      type == 'P'
    end

    def voided?
      type == 'VR' || type == 'VP' # TODO: void purchase VS void return???
    end

    def returned?
      type == 'R'
    end

    def preauthorized?
      type == 'PA'
    end

    def preauth_completed?
      type == 'PAC'
    end
  end
end
