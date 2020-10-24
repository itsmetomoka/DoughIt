class RenameLessonImageIdColumnToLesson < ActiveRecord::Migration[5.2]
  def change
  	rename_column :lessons, :lesson_image_id, :image
  end
end
