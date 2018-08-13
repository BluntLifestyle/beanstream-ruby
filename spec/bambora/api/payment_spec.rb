module Bambora::API
  describe Payment do

    before(:all) do
      # Blunt Inc Test Account
      Bambora.merchant_id      = '300205948'
      Bambora.payments_api_key = 'D5544E039FEc4cb9b8bEc18F69a04f40'
      # Bambora.recurring_api_key = '40b11f5789c94741AaC5636b47F9C302'
      # Bambora.reporting_api_key = 'dCD0320eF645452F828589F0e43B4224'
      # Bambora.batch_api_key = '0884ACAeC50d41d7807f763539dEc2d8'
    end

    describe ".create" do
      context "when using valid payment information" do
        let(:request) { build(:payment_request).to_h }

        it "makes a new payment" do
          VCR.use_cassette('payment_create_approved') do
            response = Payment.create(request)
            expect(response).to be_approved
            expect(response.type).to eq('P')
          end
        end
      end

      context "when using invalid payment information" do
        let(:request) { build(:payment_request, card: build(:card, number: '4003050500040005')).to_h }

        it "declines the payment" do
          VCR.use_cassette('payment_create_denied') do
            response = Payment.create(request)
            expect(response).to be_declined
          end
        end
      end
    end

    describe ".return" do
      let(:request) { build(:return_request, amount: 1.00) }

      it "returns a payment" do
        VCR.use_cassette 'payment_return' do
          response = Payment.return(10000001, request)
          expect(response).to be_approved
          expect(response.type).to eq('R')
        end
      end
    end

    describe ".void" do
      let(:request) { build(:void_request, amount: 1.00) }

      it "voids a payment" do
        VCR.use_cassette 'payment_void' do
          response = Payment.void(10000003, request)
          expect(response).to be_approved
          expect(response.type).to eq('VR')
        end
      end
    end

    describe ".preauth" do
      let(:request) { build(:payment_request).to_h }

      it "pre-authorizes a payment" do
        VCR.use_cassette('payment_preauth') do
          response = Payment.preauth(request)
          expect(response).to be_approved
          expect(response.type).to eq('PA')
        end
      end
    end

    describe ".completion" do
      let(:request) { build(:payment_request).to_h }

      it "completes a pre-authorized payment" do
        VCR.use_cassette('payment_completion') do
          response = Payment.completion(10000006, request)
          expect(response).to be_approved
          expect(response.type).to eq('PAC')
        end
      end
    end

    describe ".get" do
      it "gets a payment" do
        VCR.use_cassette('payment_get') do
          response = Payment.get(10000001)
          expect(response).to be_approved
          expect(response.type).to eq('P')
        end
      end
    end

    describe ".continue" do
      # context "when using Interac" do
      #   let(:interac_request) { build(:payment_request, payment_method: :interac).to_h }
      #   let(:continue_request) { build(:continue_request).to_h }
      #
      #   it "continues a payment" do
      #     VCR.use_cassette('payment_continue_interac') do
      #       response = Payment.continue(merchant_data, request)
      #       expect(response).to be_approved
      #       expect(response.type).to eq('P')
      #     end
      #   end
      # end

      # context "when using 3D Secure" do
      #   let(:secure_3d_request) { build(:continue_request, card: build(:card, number: '4003050500040005', '3d_secure': build(:secure_3d))).to_h }
      #   let(:continue_request) { build(:continue_request).to_h }
      #
      #   it "continues a payment" do
      #     VCR.use_cassette('payment_continue_3d_secure') do
      #       merchant_data = Payment.create()
      #
      #       response = Payment.continue(merchant_data, request)
      #       expect(response).to be_approved
      #       expect(response.type).to eq('P')
      #     end
      #   end
      # end
    end

  end
end
