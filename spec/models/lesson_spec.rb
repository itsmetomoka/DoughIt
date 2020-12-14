require 'rails_helper'

RSpec.describe 'Lessonモデルのテスト', type: :model do
  describe '全ての項目を入力すれば保存される' do
    it "作成成功" do
      build(:lesson)
    end
  end

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:lesson) { build(:lesson, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        lesson.name = ''
        expect(lesson.valid?).to eq false
      end
      it '4文字以下の場合は通らない' do
        lesson.name = Faker::Lorem.characters(number: 4)
        puts lesson.to_json
        expect(lesson.valid?).to eq false
      end
      it '5文字のときtrue' do
        lesson.name = Faker::Lorem.characters(number: 5)
        expect(lesson.valid?).to eq true
      end
      it '50文字の時true' do
        lesson.name = Faker::Lorem.characters(number: 50)
        expect(lesson.valid?).to eq true
      end
      it '51文字以上の場合false' do
        lesson.name = Faker::Lorem.characters(number: 51)
        expect(lesson.valid?).to eq false
      end
    end

    context 'tuitionカラム' do
      it '空欄でないこと' do
        lesson.tuition = ''
        expect(lesson.valid?).to eq false
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        lesson.tuition = ''
        expect(lesson.valid?).to eq false
      end
      it '20文字以下でないこと' do
        lesson.content = Faker::Lorem.characters(number: 19)
        expect(lesson.valid?).to eq false
      end
      it '20文字の場合true' do
        lesson.content = Faker::Lorem.characters(number: 20)
        expect(lesson.valid?).to eq true
      end
      it '200文字の場合true' do
        lesson.content = Faker::Lorem.characters(number: 200)
        expect(lesson.valid?).to eq true
      end
      it '200文字以上の場合false' do
        lesson.content = Faker::Lorem.characters(number: 201)
        expect(lesson.valid?).to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        lesson.address = ''
        expect(lesson.valid?).to eq false
      end
      it '4文字以下の場合false' do
        lesson.address = Faker::Lorem.characters(number: 4)
        expect(lesson.valid?).to eq false
      end
      it '5文字の場合true' do
        lesson.address = Faker::Lorem.characters(number: 5)
        expect(lesson.valid?).to eq true
      end
      it '100文字の場合true' do
        lesson.address = Faker::Lorem.characters(number: 100)
        expect(lesson.valid?).to eq true
      end
      it '100文字以上場合false' do
        lesson.address = Faker::Lorem.characters(number: 101)
        expect(lesson.valid?).to eq false
      end
    end

    context 'deadlineカラム' do
      it '空欄でないこと' do
        lesson.deadline = ''
        expect(lesson.valid?).to eq false
      end
      it '現在の時刻ではないこと' do
        lesson.deadline = Date.current
        expect(lesson.valid?).to eq false
      end
      it '過去の日付ではないこと' do
        travel -1.day
        lesson.deadline = Date.current
        puts lesson.to_json
        expect(lesson.valid?).to eq false
      end
      it '開催日より後ではないこと' do
        lesson.event_date = '2021-11-03 00:00:00'
        lesson.deadline = '2021-11-04 00:00:00'
        expect(lesson.valid?).to eq false
      end
    end

    context 'event_dateカラム' do
      it '空欄でないこと' do
        lesson.event_date = ''
        expect(lesson.valid?).to eq false
      end
      it '現在の時刻ではないこと' do
        lesson.event_date = Date.current
        expect(lesson.valid?).to eq false
      end
      it '過去の日付ではないこと' do
        travel -1.day
        lesson.event_date = Date.current
        expect(lesson.valid?).to eq false
      end
    end

    context 'imageカラム' do
      it '空欄でないこと' do
        lesson.image = ''
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Lesson.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nの関係' do
        expect(Lesson.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'favoriteモデルとの関係' do
      it '1:Nの関係' do
        expect(Lesson.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Reservationモデルとの関係' do
      it '1:Nの関係' do
        expect(Lesson.reflect_on_association(:reservations).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関連' do
      it '1:Nの関係' do
        expect(Lesson.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
