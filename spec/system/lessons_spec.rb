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
  describe '一覧画面のテスト' do
  	before do
  		visit lessons_path
  	end
  	context '表示の確認' do
  		it "レッスン一覧と表示される" do
  			expect(page).to have_content('レッスン一覧')
  		end
  		it '自分と他人の画像のリンク先が正しい' do
  			expect(page).to have_link '', href: user_path(lesson.user)
  		end
  		it 'レッスン名が表示される' do
  			expect(page).to have_content lesson.name 
  			expect(page).to have_content lesson2.name
  		end
  	end
  end
  describe '詳細画面のテスト' do
  	context '自分・他人共通の詳細画面の表示を確認' do
  		it 'レッスン名が表示される' do
  			visit lesson_path(lesson)
  			expect(page).to have_content lesson.name
  		end
  		it 'レッスン内容が表示される' do
  			visit lesson_path(lesson)
  			expect(page).to have_content lesson.content
  		end
  		it 'レッスン開催場所が表示される' do
  			visit lesson_path(lesson)
  			expect(page).to have_content lesson.address
  		end
  		it 'レッスン参加費が表示される' do
  			visit lesson_path(lesson)
  			expect(page).to have_content lesson.tuition.to_s(:delimited)
  		end
  		it 'レッスン最大参加人数が表示される' do
  			visit lesson_path(lesson)
  			expect(page).to have_content lesson.max_attendees
  		end
  		it 'ユーザー名が表示される' do
  			visit lesson_path(lesson)
  			expect(page).to have_content (lesson.user.name)
  		end

  	end
  	context '自分の投稿詳細画面の表示を確認' do
  		it '予約者一覧が表示される' do
  			visit lesson_path lesson
  			expect(page).to have_content '予約者一覧'
  		end
  		it 'マイページへのリンクが表示される' do
  			visit lesson_path lesson
  			expect(page).to have_link 'マイページへ', href: user_path(lesson.user)
  		end

  		it '予約ボタン表示されない' do
  			visit lesson_path lesson
  			expect(page).to have_no_link '予約する', href: lesson_reservations_path(lesson2.id)
  		end
  	end
  	context '他人の投稿詳細画面の表示を確認' do
  		it '予約ボタン表示' do
  			visit lesson_path(lesson2)
  			expect(page).to have_link '予約する', href: lesson_reservations_path(lesson2.id)
  		end
  		it '予約者一覧が表示されない' do
  			visit lesson_path (lesson2)
  			expect(page).to have_no_content '予約者一覧'
  		end
  	end
  end
  describe 'レッスン作成のテスト' do
  	before do
  		visit new_lesson_path
  	end
		context '投稿の確認' do
		  it 'New bookと表示される' do
	    	expect(page).to have_content 'レッスン開講入力フォーム'
		  end
		  it 'レッスン名フォームが表示される' do
		  	expect(page).to have_field 'lesson[name]'
		  end
		  it '内容フォームが表示される' do
		  	expect(page).to have_field 'lesson[content]'
		  end
		  it '日付フォームが表示される' do
		  	expect(page).to have_field 'lesson[event_date]'
		  end
		  it '締め切りフォームが表示される' do
		  	expect(page).to have_field 'lesson[deadline]'
		  end
		  it '最大参加人数フォームが表示される' do
		  	expect(page).to have_field 'lesson[max_attendees]'
		  end
		  it 'カテゴリーフォームが表示される' do
		  	expect(page).to have_field 'lesson[category_name]'
		  end
		  it 'カテゴリーフォームが表示される' do
		  	expect(page).to have_field 'lesson[tuition]'
		  end
		  it 'カテゴリーフォームが表示される' do
		  	expect(page).to have_field 'lesson[image]'
		  end
		  it 'Create Bookボタンが表示される' do
		  	expect(page).to have_button '確認画面に進む'
		  end
		  it '投稿に失敗する' do
		  	click_button '確認画面に進む'
		  	expect(page).to have_content 'エラー'
		  end
		end
  end
end