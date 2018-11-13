FactoryBot.define do
  factory :department do
    name { Faker::Commerce.department(1, true) }
  end
end
