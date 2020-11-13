require 'rails_helper'
describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:lesson) { create(:lesson, user: user) }
  let!(:lesson2) { create(:lesson, user: user2) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '予約のテスト' do
    before do
      visit lesson_path(lesson2)
    end

    context '予約する' do
      it "予約ボタンが表示される" do
        expect(page).to have_link '予約する', href: lesson_reservations_path(lesson2.id)
      end
      it '予約ボタンを押して予約を完了する' do
        click_link '予約する'
        expect(page).to have_content '予約一覧'
      end
    end
  end
end
