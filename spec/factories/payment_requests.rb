FactoryBot.define do
  factory :payment_request, class: 'Bambora::API::PaymentRequest' do
    to_create { true }

    order_number { rand.to_s[2..11] }
    amount { "%.2f" % (rand * 100) }
    payment_method :card
    association :billing, factory: :address
    association :shipping, factory: :address
    card
  end
end
