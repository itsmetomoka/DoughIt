require 'rails_helper'

describe 'アバウトページのテスト' do
	let(:user){ create(:user) }
	before do
		visit root_path
	end
	describe 'ボディ部分のテスト' do
		context '表示の確認' do
		  it 'ポートフォリオ閲覧リンクが表示される' do
        portfolio_link = find_all('a')[4].native.inner_text
        expect(portfolio_link).to match(/ポートフォリオ閲覧/i)
        expect(page).to have_link portfolio_link, href: users_guest_sign_in_path
      end
      it '新規登録リンクが表示される' do
        signup_link = find_all('a')[3].native.inner_text
        expect(signup_link).to match(/新規登録/i)
        expect(page).to have_link signup_link, href: new_user_registration_path
      end
      it 'ログインリンクが表示される' do
        signup_link = find_all('a')[1].native.inner_text
        expect(signup_link).to match(/ログイン/i)
        expect(page).to have_link, href: new_user_session_path
      end
    end
    context 'ログイン後のナビゲーション' do
    	before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end
      it 'ログインリンクをクリックしたらボタンが切り替わる' do
      	expect(page).to have_link 'ログアウト'
      	expect(page).to have_link 'トップページ'
      	expect(page).to have_link '教室を開く'
      	expect(page).to have_link 'レッスン一覧'
      end
    end
    context 'ログインしていない場合の挙動' do
    	it 'Log inリンクをクリックしたらログイン画面へ遷移する' do
        login_link = find_all('a')[1].native.inner_text
        click_link login_link
        expect(current_path).to eq(new_user_session_path)
      end
      it 'Sign Upリンクをクリックしたら新規登録画面に遷移する' do
        link = find('.button-classic-link', text: '新規登録').click
        expect(current_path).to eq(new_user_registration_path)
      end
      it '閲覧用リンクをクリックしたらトップページへ' do
        link = find('.button-classic-link', text: '(ポートフォリオ閲覧)').click
        expect(current_path).to eq(top_path)
      end
    end
  end
end
