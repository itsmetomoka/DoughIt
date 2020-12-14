FactoryBot.define do
  factory :lesson do
    name { Faker::Lorem.characters(number: 10) }
    event_date { '2021-11-05 00:00:00' }
    deadline { '2021-11-04 00:00:00' }
    max_attendees { 3 }
    category
    image { '3909561_s.jpg' }
    image_file_name {'3909561_s.jpg'}
    tuition { 2000 }
    content { Faker::Lorem.characters(number: 20) }
    address { '東京都千代田区霞ヶ関' }
    user
  end
end
