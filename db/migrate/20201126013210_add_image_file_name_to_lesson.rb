class AddImageFileNameToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :image_file_name, :string
  end
end
