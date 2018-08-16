module Bambora::API
  describe Profile do

    before do
      Bambora.merchant_id      = '300205948'
      Bambora.profiles_api_key = '1c1Ea110bd8F402a8aF2Bb3d0b32BD7b'
    end

    describe '.create' do
      context "when it is given a credit card" do
        it 'creates a payment profile' do
          VCR.use_cassette('profile/create_from_card') do
            profile = Profile.create(
              card: {
                name: 'John Smith',
                number: '4504481742333',
                expiry_month: '12',
                expiry_year: '18',
                cvd: '123'
              }
            )

            expect(profile).to be_a Profile
            expect(profile.id).not_to be_empty
            expect(profile.name).to eq('John Smith')
          end
        end
      end

      context "when it is given a token" do
        it 'creates a payment profile' do
          token = nil

          VCR.use_cassette('profile/token_for_create') do
            token = Token.create(
              name: 'Alice Smith',
              number: '5100000010001004',
              expiry_month: '12',
              expiry_year: '18',
              cvd: '123'
            )
          end

          VCR.use_cassette('profile/create_from_token') do
            profile = Profile.create(token)

            expect(profile).to be_a Profile
            expect(profile.id).not_to be_empty
            expect(profile.name).to eq('Alice Smith')
          end
        end
      end
    end

  end
end
