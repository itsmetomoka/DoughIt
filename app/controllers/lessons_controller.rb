class LessonsController < ApplicationController
  before_action :authenticate_user!, except: [:about]

  def top
    @lessons = Lesson.only_active
    @user = current_user
    @reserved_lessons = current_user.reservations
    @favorites = Favorite.where(user_id: current_user.id)
    # カレンダーには過去のレッスンも表示する
    @lessons_calendar = Lesson.all
  end

  def about
  end

  def new
    @lesson = Lesson.new
  end

  def confirm
    @lesson = current_user.lessons.new(lesson_params)
    # 入力フォームに画像以外の不備がないか確認
    if @lesson.invalid?
      # 復元できるように値を渡す準備をする
      @lesson.image_cache = @lesson.image.cache_name
      render :new
    else
      # new画面に戻った後画像を変更していなければ画像をcacheを使って復元
      if @lesson.image.blank? && @lesson.image_cache.present?
        @lesson.image.retrieve_from_cache! @lesson.image_cache
        # 画像が選択されていなければバリデーションをかける
        # (モデルに定義するとキャッシュで復元できる場合でも空欄とみなされるため）
      elsif @lesson.image.blank? && @lesson.image_cache.blank?
        flash[:validate_image] = "画像を選択してください"
        render :new
      end
      @lesson.image_cache = @lesson.image.cache_name
    end
  end

  def back
    @lesson = current_user.lessons.new(lesson_params)
    @lesson.image.retrieve_from_cache! @lesson.image_cache
    @lesson.image_cache = @lesson.image.cache_name
    render :new
  end

  def create
    @lesson = current_user.lessons.new(lesson_params)
    # もう一度キャッシュを使って復元する
    @lesson.image.retrieve_from_cache! @lesson.image_cache
    @lesson.save
    redirect_to lessons_complete_path
  end

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      all_lesson = @user.lessons.only_active
    else
      all_lesson = Lesson.only_active
    end
    @lessons = all_lesson.page(params[:page]).reverse_order
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def complete
    @lesson = current_user.lessons.last
  end

  def history
    all_lesson = current_user.lessons.not_active
    @lessons = all_lesson.page(params[:page]).reverse_order
  end

  private

  def lesson_params
    params.require(:lesson).permit(:user_id, :name, :event_date, :tuition, :content,
     :address, :latitude, :longitude, :deadline, :max_attendees, :category_name, :image,
      :image_cache, :is_active)
  end
end
