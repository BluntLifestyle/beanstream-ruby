require 'ffaker'
require 'date'

FactoryBot.define do
  factory :card, class: 'Bambora::API::Card' do
    to_create { true }

    number '4504481742333'
    name { FFaker::Name.name }
    expiry_month '12'
    expiry_year { (Date.today.year % 100).to_s }
    cvd '123'
  end
end
