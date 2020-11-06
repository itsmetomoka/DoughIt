FactoryBot.define do
  factory :review do
    review { Faker::Lorem.characters(number:5) }
    rate {3}
    user
  end
end