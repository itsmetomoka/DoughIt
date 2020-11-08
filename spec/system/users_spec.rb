require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button 'Sign up'
        expect(page).to have_content '教室一覧'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button 'Sign up'
        expect(page).to have_content 'エラー'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'Log in'

        expect(page).to have_content '教室一覧'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  let!(:lesson) { create(:lesson, user: user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  describe '編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '自分の画面が表示' do
        visit edit_user_path(test_user2)
        expect(current_path).to eq('/users/1/edit')
      end
    end
    context '表示の確認' do
      before do
        visit edit_user_path(user)
      end
      it '編集ページと表示される' do
        expect(page).to have_content('編集ページ')
      end
      it '編集フォームに名前が表示されている' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it '自己紹介編集フォームに自分の自己紹介が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '編集に成功する' do
        click_button '編集内容を保存する'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '編集内容を保存する'
        expect(page).to have_content 'エラー'
      end
    end
  end
  describe '詳細画面のテスト' do
    before do
      visit user_path(user)
    end
    context '表示の確認' do
      it 'ページ名が表示される' do
        expect(page).to have_content(user.name + 'さんのページ')
      end
      it '名前さんのレッスンと表示される' do
        expect(page).to have_content(user.name + 'さんのレッスン')
      end
      it 'レッスン画像のリンク先が正しい' do
        expect(page).to have_link '', href: lesson_path(lesson)
      end
      it 'レッスン名が表示される' do
        expect(page).to have_content(lesson.name)
      end

    end
  end
end