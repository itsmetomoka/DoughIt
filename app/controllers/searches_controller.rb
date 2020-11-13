class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    if params[:word]
      @word = params[:word]
      all_lesson = Lesson.search(@word).only_active
    elsif params[:category_name]
      @category = params[:category_name].to_i
      all_lesson = Lesson.search(@category).only_active
    end
    @lessons = all_lesson.page(params[:page]).reverse_order
    @lessons_count = all_lesson.count
  end

  def categorize
    sort = params[:sort]
    category = params[:category]
    date = params[:date]
    user_id = params[:user_id]

    if params[:not_active] == '1'
      all_lesson = Lesson.sort(sort, category, date, user_id)
    else
      all_lesson = Lesson.sort(sort, category, date, user_id).only_active
    end
    if user_id.present?
      @user = User.find(user_id)
    end
    @lessons = all_lesson.page(params[:page]).reverse_order
  end
end
