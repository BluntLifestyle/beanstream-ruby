module Bambora
  class BamboraError < StandardError

    attr_reader :code, :category, :message, :http_status_code

    def initialize(code = nil, category = nil, message = nil, http_status_code = nil)
      @code = code
      @category = category
      @message = message
      @http_status_code = http_status_code
    end

    def is_user_error
      false
    end

    def user_facing_message
      "There was an error processing your request. Please try again or use a different card."
    end
  end


  class BusinessRuleError < BamboraError
    def initialize(code, category, message, http_status_code)
      super(code, category, message, http_status_code)
    end
  end

  class UnauthorizedError < BamboraError
    def initialize(code, category, message, http_status_code)
      super(code, category, message, http_status_code)
    end
  end

  class ForbiddenError < BamboraError
    def initialize(code, category, message, http_status_code)
      super(code, category, message, http_status_code)
    end
  end

  class InvalidRequestError < BamboraError
    def initialize(code, category, message, http_status_code)
      super(code, category, message, http_status_code)
    end

    def is_user_error
      if (@category ==1)
        true
      elsif (@category == 3 && code == 52)
        true
      else
        false
      end
    end

    def user_facing_message
      if is_user_error
        return @message
      else
        super
      end
    end

  end

  class InternalServerError < BamboraError
    def initialize(code, category, message, http_status_code)
      super(code, category, message, http_status_code)
    end
  end

  class UnsupportedPaymentMethodError < BamboraError; end

end
