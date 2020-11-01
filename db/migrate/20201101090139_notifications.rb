class Notifications < ActiveRecord::Migration[5.2]
  def up
  	change_column :notifications, :checked, :boolean, default: false
  end
  def down
  	change_column :notifications, :checked, :boolean, null: false
  end

  def change
    rename_column :notifications, :checked, :is_checked
  end
end
