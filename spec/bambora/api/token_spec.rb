module Bambora::API
  describe Token do
    describe '.create' do
      let (:request) { TokenRequest.new(create(:card)) }

      it "creates a token" do
        VCR.use_cassette('token/create') do
          response = Token.create(request)
          expect(response).to be_a TokenResponse
          expect(response.token).not_to be_empty
        end
      end
    end
  end
end
