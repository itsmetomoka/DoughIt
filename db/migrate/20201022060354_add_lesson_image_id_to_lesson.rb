class AddLessonImageIdToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :lesson_image_id, :string
  end
end
