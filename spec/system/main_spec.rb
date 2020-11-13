require 'rails_helper'

describe 'ユーザー権限のテスト' do
  let!(:user) { create(:user) }
  let!(:lesson) { create(:lesson, user: user) }

  describe 'ログインしていない場合' do
    context 'レッスン関連のURLにアクセス' do
      it 'トップ画面に遷移できない' do
        visit top_path
        expect(current_path).to eq('/users/sign_in')
      end
      it '一覧画面に遷移できない' do
        visit lessons_path
        expect(current_path).to eq('/users/sign_in')
      end
      it '詳細画面に遷移できない' do
        visit lesson_path(lesson.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it '新規作成画面に遷移できない' do
        visit new_lesson_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'カテゴリー検索画面に遷移できない' do
        visit search_path
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end

  describe 'ログインしてない場合' do
    context 'ユーザー関連のURLにアクセス' do
      it 'ユーザー詳細画面' do
        visit user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it 'ユーザー編集画面' do
        visit edit_user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it 'ユーザー退会画面' do
        visit users_check_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'ユーザーレビュー一覧' do
        visit user_reviews_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end
