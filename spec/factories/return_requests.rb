FactoryBot.define do
  factory :return_request, class: 'Bambora::API::ReturnRequest' do
    to_create { true }

    order_number { rand.to_s[2..11] }
    amount { "%.2f" % (rand * 100) }
  end
end
