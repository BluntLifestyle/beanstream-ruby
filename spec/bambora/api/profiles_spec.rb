module Bambora::API
  describe Profiles do

    subject { Profiles.new }

    before(:all) do
      Bambora.merchant_id = "300200578"
      Bambora.payments_api_key = "4BaD82D9197b4cc4b70a221911eE9f70"
      Bambora.profiles_api_key = "D97D3BE1EE964A6193D17A571D9FBC80"
    end

    it "make profiles url be the same" do
      expect(subject.profile_url.path).to eq "/v1/profiles"
    end

    it "make profiles/cards url be the same" do
      expect(subject.profile_cards_url.path).to eq "/v1/profiles/cards"
    end
    
  end
end
