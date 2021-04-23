FactoryBot.define do
  factory :item do
    product_name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 11) }
    product_status_id { Faker::Number.between(from: 2, to: 7) }
    shipping_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    delivery_day_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user
    after(:build) do |message|
      message.image.attach(io: File.open('public/test_image.jpg'), filename: 'test_image.png')
    end
  end
end
