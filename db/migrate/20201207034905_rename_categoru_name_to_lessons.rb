class RenameCategoruNameToLessons < ActiveRecord::Migration[5.2]
  def change
  	rename_column :lessons, :category_name, :category_id
  end
end
