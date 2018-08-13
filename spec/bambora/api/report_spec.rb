module Bambora::API
  describe Report do

    before do
      # Blunt Inc Test Account
      Bambora.merchant_id      = '300205948'
      # Bambora.payments_api_key = 'D5544E039FEc4cb9b8bEc18F69a04f40'
      # Bambora.recurring_api_key = '40b11f5789c94741AaC5636b47F9C302'
      Bambora.reporting_api_key = 'dCD0320eF645452F828589F0e43B4224'
    end

    describe ".search" do
      it "searches for transactions" do
        VCR.use_cassette('report/search') do
          response = Report.search(criteria: [{ field: 'amount', operator: 'equals', value: 10.0 }] )
          expect(response.records).not_to be_empty
          expect(response.records.first).to be_a SearchRecord
        end
      end
    end

    describe ".minimal" do
      # TODO: unclear how/if this should work. Documentation is lacking and
      # official implementation in ruby is absent. Maybe look at other languages?
      # 
      # it "searches for transactions" do
      #   VCR.use_cassette('report/minimal') do
      #     response = Report.minimal(criteria: [{ field: 'amount', operator: 'equals', value: 10.0 }] )
      #     expect(response.records).not_to be_empty
      #     expect(response.records.first).to be_a SearchRecord
      #   end
      # end
    end

  end
end
