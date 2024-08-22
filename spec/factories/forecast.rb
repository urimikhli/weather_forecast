
FactoryBot.define do
  temperature = Faker::Number.between(from: -135, to: 135)
  factory :forecast do
    zipcode { Faker::Address.zip_code }
    todays_temp { temperature }
    high_temp { temperature + 12 }
    low_temp { temperature - 12 }
  end
end
