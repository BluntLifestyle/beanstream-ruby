require 'ffaker'

FactoryBot.define do
  factory :address, class: 'Bambora::API::Address' do
    to_create { true }

    name { FFaker::Name.name }
    address_line1 '1407 Graymalkin Lane'
    address_line2 ''
    city 'Gatineau'
    province 'QC'
    country 'CA'
    postal_code '111 111'
    phone_number ''
    email_address ''
  end
end
