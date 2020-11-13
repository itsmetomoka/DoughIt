FactoryBot.define do
  password = Faker::Lorem.characters(number: 8)

  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
