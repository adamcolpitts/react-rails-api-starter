FactoryBot.define do
  factory :ingredient do
    description { Faker::Lorem.paragraph }
    drink_id nil
  end
end