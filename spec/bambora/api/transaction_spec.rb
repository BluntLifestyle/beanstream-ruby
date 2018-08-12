module Bambora::API
  describe Transaction do

    describe "#encode" do
      context "when it is given `12345` as `merchant_id` and `abcdefg` as `passcode`" do
        subject { Transaction.new }

        it "encodes the merchant_id and passcode as base64 and returns `MTIzNDU6YWJjZGVmZw==`" do
          expect(subject.encode("12345", "abcdefg")).to eq "MTIzNDU6YWJjZGVmZw=="
        end
      end
    end

    describe "#post" do

    end

  end

end
