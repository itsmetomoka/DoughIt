class AddIsActiveToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :is_active, :boolean, default: true
  end
end
