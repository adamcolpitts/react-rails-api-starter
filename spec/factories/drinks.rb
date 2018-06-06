FactoryBot.define do
  factory :drink do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    steps { Faker::Lorem.sentence }
    source { Faker::Lorem.word }
  end
end