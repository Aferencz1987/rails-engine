FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraphs}
    unit_price { Faker::Commerce.price}
  end
end
