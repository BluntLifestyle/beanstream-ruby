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
          VCR.use_cassette('payment/create_approved') do
            response = Payment.create(request)
            expect(response).to be_approved
            expect(response).to be_purchased
          end
        end
      end

      context "when using invalid payment information" do
        let(:request) { build(:payment_request, card: build(:card, number: '4003050500040005')).to_h }

        it "declines the payment" do
          VCR.use_cassette('payment/create_denied') do
            response = Payment.create(request)
            expect(response).to be_declined
          end
        end
      end
    end

    describe ".return" do
      let(:approve_request) { build(:payment_request, amount: 10.00) }
      let(:request) { build(:return_request, amount: 10.00, order_number: approve_request.order_number) }

      it "returns a payment" do
        approve_response = nil

        VCR.use_cassette('payment/create_approve_for_return') do
          approve_response = Payment.create(approve_request)
          expect(approve_response).to be_approved
          expect(approve_response).to be_purchased
        end

        VCR.use_cassette 'payment/return' do
          response = Payment.return(approve_response.id, request)
          expect(response).to be_approved
          expect(response).to be_returned
        end
      end
    end

    describe ".void" do
      let(:approve_request) { build(:payment_request, amount: 5.00) }
      let(:request) { build(:void_request, amount: 5.00) }

      it "voids a payment" do
        approve_response = nil

        VCR.use_cassette('payment/create_approve_for_void') do
          approve_response = Payment.create(approve_request)
          expect(approve_response).to be_approved
          expect(approve_response).to be_purchased
        end

        VCR.use_cassette 'payment/void' do
          response = Payment.void(approve_response.id, request)
          expect(response).to be_approved
          expect(response).to be_voided
        end
      end
    end

    describe ".preauth" do
      let(:request) { build(:payment_request).to_h }

      it "pre-authorizes a payment" do
        VCR.use_cassette('payment/preauth') do
          response = Payment.preauth(request)
          expect(response).to be_approved
          expect(response).to be_preauthorized
        end
      end
    end

    describe ".completion" do
      let(:request) { build(:payment_request).to_h }

      it "completes a pre-authorized payment" do
        VCR.use_cassette('payment/completion') do
          response = Payment.completion(10000006, request)
          expect(response).to be_approved
          expect(response).to be_preauth_completed
        end
      end
    end

    describe ".get" do
      it "gets a payment" do
        VCR.use_cassette('payment/get') do
          response = Payment.get(10000001)
          expect(response).to be_approved
          expect(response).to be_purchased
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