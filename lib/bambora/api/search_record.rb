module Bambora::API
  class SearchRecord
    include HashHelpers

    attr_accessor :row_id,  :trn_id, :trn_date_time, :trn_type,
                  :trn_order_number, :trn_payment_method, :trn_comments,
                  :trn_masked_card, :trn_amount, :trn_returns, :trn_completions,
                  :trn_voided, :trn_response, :trn_card_type, :trn_batch_no,
                  :trn_avs_result, :trn_cvd_result, :trn_cavv_result,
                  :trn_card_expiry, :message_id, :message_text, :trn_card_owner,
                  :trn_ip, :trn_approval_code, :trn_reference, :b_name,
                  :b_email, :b_phone, :b_address1, :b_address2, :b_city,
                  :b_province, :b_postal, :b_country, :s_name, :s_email,
                  :s_phone, :s_address1, :s_address2, :s_city, :s_province,
                  :s_postal, :s_country, :ref1, :ref2, :ref3, :ref4, :ref5,
                  :product_name, :product_id, :customer_code, :currency_abbr,
                  :merchant_id, :merchant_name, :entry_method,
                  :authorizing_merchant_id

    def initialize(args = {})
      args = {} if args.nil?
      if args.respond_to? :symbolize_keys!
        args.symbolize_keys!
      else
        symbolize_keys(args)
      end
      self.row_id = args[:row_id]
      self.trn_id = args[:trn_id]
      self.trn_date_time = args[:trn_date_time]
      self.trn_type = args[:trn_type]
      self.trn_order_number = args[:trn_order_number]
      self.trn_payment_method = args[:trn_payment_method]
      self.trn_comments = args[:trn_comments]
      self.trn_masked_card = args[:trn_masked_card]
      self.trn_amount = args[:trn_amount]
      self.trn_returns = args[:trn_returns]
      self.trn_completions = args[:trn_completions]
      self.trn_voided = args[:trn_voided]
      self.trn_response = args[:trn_response]
      self.trn_card_type = args[:trn_card_type]
      self.trn_batch_no = args[:trn_batch_no]
      self.trn_avs_result = args[:trn_avs_result]
      self.trn_cvd_result = args[:trn_cvd_result]
      self.trn_cavv_result = args[:trn_cavv_result]
      self.trn_card_expiry = args[:trn_card_expiry]
      self.message_id = args[:message_id]
      self.message_text = args[:message_text]
      self.trn_card_owner = args[:trn_card_owner]
      self.trn_ip = args[:trn_ip]
      self.trn_approval_code = args[:trn_approval_code]
      self.trn_reference = args[:trn_reference]
      self.b_name = args[:b_name]
      self.b_email = args[:b_email]
      self.b_phone = args[:b_phone]
      self.b_address1 = args[:b_address1]
      self.b_address2 = args[:b_address2]
      self.b_city = args[:b_city]
      self.b_province = args[:b_province]
      self.b_postal = args[:b_postal]
      self.b_country = args[:b_country]
      self.s_name = args[:s_name]
      self.s_email = args[:s_email]
      self.s_phone = args[:s_phone]
      self.s_address1 = args[:s_address1]
      self.s_address2 = args[:s_address2]
      self.s_city = args[:s_city]
      self.s_province = args[:s_province]
      self.s_postal = args[:s_postal]
      self.s_country = args[:s_country]
      self.ref1 = args[:ref1]
      self.ref2 = args[:ref2]
      self.ref3 = args[:ref3]
      self.ref4 = args[:ref4]
      self.ref5 = args[:ref5]
      self.product_name = args[:product_name]
      self.product_id = args[:product_id]
      self.customer_code = args[:customer_code]
      self.currency_abbr = args[:currency_abbr]
      self.merchant_id = args[:merchant_id]
      self.merchant_name = args[:merchant_name]
      self.entry_method = args[:entry_method]
      self.authorizing_merchant_id = args[:authorizing_merchant_id]
    end

    def to_h
      {
        row_id: row_id,
        trn_id: trn_id,
        trn_date_time: trn_date_time,
        trn_type: trn_type,
        trn_order_number: trn_order_number,
        trn_payment_method: trn_payment_method,
        trn_comments: trn_comments,
        trn_masked_card: trn_masked_card,
        trn_amount: trn_amount,
        trn_returns: trn_returns,
        trn_completions: trn_completions,
        trn_voided: trn_voided,
        trn_response: trn_response,
        trn_card_type: trn_card_type,
        trn_batch_no: trn_batch_no,
        trn_avs_result: trn_avs_result,
        trn_cvd_result: trn_cvd_result,
        trn_cavv_result: trn_cavv_result,
        trn_card_expiry: trn_card_expiry,
        message_id: message_id,
        message_text: message_text,
        trn_card_owner: trn_card_owner,
        trn_ip: trn_ip,
        trn_approval_code: trn_approval_code,
        trn_reference: trn_reference,
        b_name: b_name,
        b_email: b_email,
        b_phone: b_phone,
        b_address1: b_address1,
        b_address2: b_address2,
        b_city: b_city,
        b_province: b_province,
        b_postal: b_postal,
        b_country: b_country,
        s_name: s_name,
        s_email: s_email,
        s_phone: s_phone,
        s_address1: s_address1,
        s_address2: s_address2,
        s_city: s_city,
        s_province: s_province,
        s_postal: s_postal,
        s_country: s_country,
        ref1: ref1,
        ref2: ref2,
        ref3: ref3,
        ref4: ref4,
        ref5: ref5,
        product_name: product_name,
        product_id: product_id,
        customer_code: customer_code,
        currency_abbr: currency_abbr,
        merchant_id: merchant_id,
        merchant_name: merchant_name,
        entry_method: entry_method,
        authorizing_merchant_id: authorizing_merchant_id
      }
    end

    def to_json
      to_h.to_json
    end

  end
end
