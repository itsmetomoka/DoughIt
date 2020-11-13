require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe '作成テスト' do
    it "名前,email,password,password-confirm, があれば作成できる" do
      build(:user)
    end
  end

  describe 'バリデーションのテスト' do
    subject { test_user.valid? }

    let(:user) { build(:user) }

    context 'nameカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
      it '空欄の場合エラーが出る' do
        test_user.name = ''
        test_user.valid?
        expect(test_user.errors[:name]).to include("を入力してください")
      end
      it '1文字の場合false' do
        test_user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字の場合true' do
        test_user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字の場合true' do
        test_user.name = Faker::Lorem.characters(number: 20)
        puts user.to_json
        is_expected.to eq true
      end
      it '21文字以上の場合false' do
        test_user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '1文字の場合エラーが出る' do
        test_user.name = Faker::Lorem.characters(number: 1)
        test_user.valid?
        expect(test_user.errors[:name]).to include("は2文字以上で入力してください")
      end
      it '20文字以上の場合エラーが出る' do
        test_user.name = Faker::Lorem.characters(number: 21)
        test_user.valid?
        expect(test_user.errors[:name]).to include("は20文字以内で入力してください")
      end
    end

    context 'メールアドレスのカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.email = ''
        is_expected.to eq false
      end
      it '空欄の場合エラーが出る' do
        test_user.email = ''
        test_user.valid?
        expect(test_user.errors[:email]).to include("を入力してください")
      end
      it '@マークを含むこと' do
        test_user.email = 'aa.com'
        is_expected.to eq false
      end
      it '間違った記述の場合エラーが出る' do
        test_user.email = ''
        test_user.valid?
        expect(test_user.errors[:email]).to include("が正しくありません")
      end
      it '重複したメールアドレスでないこと' do
        User.create(
          name: "Tarou",
          email: "test@example.com",
          password: "xxxxxxx",
        )
        user = User.new(
          name: "Hanako",
          email: "test@example.com",
          password: "xxxxxxx",
        )
        expect(user.valid?).to eq false
      end
    end

    context 'passwordのカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.password = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.password = ''
        test_user.valid?
        expect(test_user.errors[:password]).to include("を入力してください")
      end
      it '6文字の時true' do
        password = Faker::Lorem.characters(number: 6)
        user = build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq true
      end
      it '6文字未満の時false' do
        password = Faker::Lorem.characters(number: 5)
        user = build(:user, password: password, password_confirmation: password)
        expect(user.valid?).to eq false
      end
      it '６文字未満の場合はエラーが出る' do
        test_user.password = Faker::Lorem.characters(number: 1)
        test_user.valid?
        expect(test_user.errors[:password]).to include("は6文字以上で入力してください")
      end
      it 'パスワードが不一致' do
        test_user.password = "password"
        test_user.password_confirmation = "passward"
        test_user.valid?
        expect(test_user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end

    context '自己紹介文のカラム' do
      let(:test_user) { user }

      it '300文字以上でないこと' do
        test_user.introduction = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
      it '300文字の時true' do
        test_user.introduction = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Lessonモデルとの関係' do
      it '1:Nの関係' do
        expect(User.reflect_on_association(:lessons).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nの関係' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nの関係' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Reservationモデルとの関係' do
      it '1:Nの関係' do
        expect(User.reflect_on_association(:reservations).macro).to eq :has_many
      end
    end

    context 'Reviewモデルとの関係' do
      it '1:Nの関係' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end

    context 'active_notificationモデルとの関連' do
      let(:target) { :active_notifications }

      it '1:Nの関係' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it '結合するモデルのクラスはNotification' do
        expect(User.reflect_on_association(:active_notifications).class_name).to eq 'Notification'
      end
    end

    context 'passive_notificationモデルとの関連' do
      let(:target) { :passive_notifications }

      it '1:Nの関係' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
      it '結合するモデルのクラスはNotification' do
        expect(User.reflect_on_association(:passive_notifications).class_name).to eq 'Notification'
      end
    end
  end
end
