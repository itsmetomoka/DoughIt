class AddTuitionToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :tuition, :integer
  end
end
