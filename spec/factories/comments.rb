FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number: 20) }
    user
    lesson
  end
end
