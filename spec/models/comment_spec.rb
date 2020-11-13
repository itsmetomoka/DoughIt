require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:lesson) { create(:lesson, user_id: user.id) }
  let!(:comment) { build(:comment, user_id: user.id, lesson_id: lesson.id) }

  describe 'バリデーションのテスト' do
    context 'commentカラム' do
      it '空欄でないこと' do
        comment.comment = ''
        expect(comment.valid?).to eq false
      end
      it '201文字以上の時false' do
        comment.comment = Faker::Lorem.characters(number: 201)
        expect(comment.valid?).to eq false
      end
      it '200文字の時true' do
        comment.comment = Faker::Lorem.characters(number: 200)
        expect(comment.valid?).to eq true
      end
      it '2文字の時true' do
        comment.comment = Faker::Lorem.characters(number: 2)
        expect(comment.valid?).to eq true
      end
      it '1文字の時false' do
        comment.comment = Faker::Lorem.characters(number: 1)
        expect(comment.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1の関係になっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'PostImageモデルとの関係' do
      it 'N:1の関係となっていること' do
        expect(Comment.reflect_on_association(:lesson).macro).to eq :belongs_to
      end
    end
  end
end
