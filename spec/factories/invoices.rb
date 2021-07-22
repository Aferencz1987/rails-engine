FactoryBot.define do
  factory :invoice do
    status { ['shipped', 'unshipped'].sample }
  end
end
