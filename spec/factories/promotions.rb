FactoryBot.define do
  factory :promotion do
    code { Faker::Commerce.promotion_code(2) }
    start_date { Faker::Date.between(2.days.ago, Date.today) }
    end_date { Faker::Date.between(Date.today, Date.today + 2) }
    percent { Faker::Number.between(1, 100) }
  end
end
