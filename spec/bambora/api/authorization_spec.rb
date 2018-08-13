module Bambora::API
  describe Authorization do

    describe "#encoded_passcode" do
      context "when it is given `12345` as `merchant_id` and `abcdefg` as `passcode`" do
        subject { Object.new.extend Authorization }

        it "encodes the merchant_id and passcode as base64 and returns `MTIzNDU6YWJjZGVmZw==`" do
          subject.merchant_id = "12345"
          subject.passcode = "abcdefg"
          expect(subject.encoded_passcode).to eq "MTIzNDU6YWJjZGVmZw=="
        end
      end
    end
  end

end
