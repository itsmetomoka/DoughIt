FactoryBot.define do
  factory :notification do
    action { "" }
    checked { Faker::Boolean.boolean }
    event
    association :visitor
    association :visited
  end
end
