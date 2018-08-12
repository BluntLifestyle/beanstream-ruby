module Bambora::API
  describe Reporting do

    subject { Reporting.new }

    before(:all) do
      Bambora.merchant_id = "300200578"
      Bambora.payments_api_key = "4BaD82D9197b4cc4b70a221911eE9f70"
      Bambora.reporting_api_key = "4e6Ff318bee64EA391609de89aD4CF5d"
    end

    it "make reports url be the same" do
      expect(subject.reports_url.path).to eq "/v1/reports"
    end

  end
end
