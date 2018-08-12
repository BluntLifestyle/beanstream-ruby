module Bambora::API
  class Profiles < Transaction

    def profile_url
      uri = URI(Bambora.api_base_url)
      uri.path += '/profiles'
      uri
    end

    def profile_cards_url
      uri = URI(Bambora.api_base_url)
      uri.path += "/profiles/cards"
      uri
    end

    def getCreateProfileWithCardTemplate()
      request = template
      request[:card] = {
        :name => "",
        :number => "",
        :expiry_month => "",
        :expiry_year => "",
        :cvd => ""
      }
      return request
    end

    def getCreateProfileWithTokenTemplate()
      request = template
      request[:token] = {
        :name => "",
        :code => ""
      }
      return request
    end

    # a template for a Secure Payment Profile
    def template
      {
        language: "",
        comments: "",
        billing: {
          name: "",
          address_line1: "",
          address_line2: "",
          city: "",
          province: "",
          country: "",
          postal_code: "",
          phone_number: "",
          email_address: ""
        },
        shipping: {
          name: "",
          address_line1: "",
          address_line2: "",
          city: "",
          province: "",
          country: "",
          postal_code: "",
          phone_number: "",
          email_address: ""
        },
        custom: {
          ref1: "",
          ref2: "",
          ref3: "",
          ref4: "",
          ref5: ""
        }
      }
    end

    def create_profile(profile)
      val = post("POST", profile_url, Bambora.merchant_id, Bambora.profiles_api_key, profile)
    end

    def delete_profile(profileId)
      delUrl = profile_url+"/"+profileId
      val = post("DELETE", delUrl, Bambora.merchant_id, Bambora.profiles_api_key, nil)
    end

    def get_profile(profileId)
      getUrl = profile_url+"/"+profileId
      val = post("GET", getUrl, Bambora.merchant_id, Bambora.profiles_api_key, nil)
    end

    def update_profile(profile)
      getUrl = profile_url+"/"+profile['customer_code']
      # remove card field for profile update. Card updates are done using update_profile_card()
      if (profile['card'] != nil)
        profile.tap{ |h| h.delete('card') }
      end
      val = post("PUT", getUrl, Bambora.merchant_id, Bambora.profiles_api_key, profile)
    end

    def self.profile_successfully_created(response)
      success = response['code'] == 1 && response['message'] == "Operation Successful"
    end

    def self.profile_successfully_deleted(response)
      success = response['code'] == 1 && response['message'] == "Operation Successful"
    end

    def add_profile_card(profile, card)
      addCardUrl = profile_url + "/" + profile['customer_code'] + "/cards/"
      val = post("POST", addCardUrl, Bambora.merchant_id, Bambora.profiles_api_key, card)
    end

    def get_profile_card(profile)
      getCardUrl = profile_url + "/" + profile['customer_code'] + "/cards/"
      val = post("get", getCardUrl, Bambora.merchant_id, Bambora.profiles_api_key)
    end

    def update_profile_card(profile,card_index,card)
      updateUrl = profile_url + "/" + profile['customer_code'] + "/cards/" + card_index.to_s
      val = post("PUT", updateUrl, Bambora.merchant_id, Bambora.profiles_api_key, card)
    end

    def delete_profile_card(profile,card_index)
      deleteUrl = profile_url + "/" + profile['customer_code'] + "/cards/" + card_index.to_s
      val = post("DELETE", deleteUrl, Bambora.merchant_id, Bambora.profiles_api_key, nil)
    end
	end
end
