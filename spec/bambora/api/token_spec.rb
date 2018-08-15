module Bambora::API
  describe Token do
    describe '.create' do
      let(:card) { create(:card) }
      let (:request) { TokenRequest.new(card) }

      it "creates a token" do
        VCR.use_cassette('token/create') do
          response = Token.create(request)
          expect(response).to be_a Token
          expect(response.code).not_to be_empty
          expect(response.name).to eq(card.name)
        end
      end
    end
  end
end
