require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:review) { build(:review, user_id: user.id, reviewer_id: user.id) }
  
  describe 'バリデーションのテスト' do
    context 'reviewカラム' do
      it '空欄でないこと' do
        review.review = ''
        expect(review.valid?).to eq false;
      end
      it '1文字の場合は通らない' do
        review.review = Faker::Lorem.characters(number:1)
        expect(review.valid?).to eq false;
      end
      it '2文字の場合true' do
        review.review = Faker::Lorem.characters(number:2)
        expect(review.valid?).to eq true;
      end
      it '100文字の場合true' do
        review.review = Faker::Lorem.characters(number:100)
        expect(review.valid?).to eq true;
      end
      it '101文字の場合true' do
        review.review = Faker::Lorem.characters(number:101)
        expect(review.valid?).to eq false;
      end
    end
  end
end