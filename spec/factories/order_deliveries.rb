FactoryBot.define do
  factory :order_delivery do
    token { 'tok_abcdefghijk00000000000000000' }
    user_id { 1 }
    item_id { 5 }
    post_code { "#{Faker::Number.decimal_part(digits: 3)}-#{Faker::Number.decimal_part(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { Gimei.address.city.kanji }
    address { Faker::Lorem.sentence }
    building_name { Faker::Lorem.sentence }
    phone_num { Faker::Number.decimal_part(digits: 11) }
  end
end
