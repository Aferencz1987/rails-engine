FactoryBot.define do
  factory :invoice_item do
    unit_price { Faker::Commerce.price }
    quantity { Faker::Number.within(range: 1..10) }
  end
end
