require 'rails_helper'
describe '投稿のテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '検索テスト' do
    before do
      visit top_path
    end

    context '表示の確認' do
      it "検索結果が表示される" do
        fill_in 'word', with: 'some'
        click_button '検索'
        expect(page).to have_content '検索結果'
      end
    end
  end
end
