require 'rails_helper'
describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'Log in'
  end
  describe 'レビューテスト' do
  	context '表示の確認' do
  		it "レビューが表示される" do
        visit user_reviews_path(user2)
        expect(page).to have_content 'レビュー'
  		end
  	end
  end
end