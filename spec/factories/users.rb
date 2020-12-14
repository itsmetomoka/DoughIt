FactoryBot.define do
  password = Faker::Lorem.characters(number: 8)

  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    image { '3909561_s.jpg' }
    image_file_name {'3909561_s.jpg'}
    password { password }
    password_confirmation { password }
  end
end
