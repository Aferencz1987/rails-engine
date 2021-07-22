FactoryBot.define do
  factory :invoice_items do
    unit_price { Faker::Commerce.price }
    quanitity { Faker::Number.within(range: 1..10) }
  end
end
