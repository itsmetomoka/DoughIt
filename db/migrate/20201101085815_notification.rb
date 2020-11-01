class Notification < ActiveRecord::Migration[5.2]
  def up
  	change_column :notifications, :checked, :boolean, default: false
  end
  def up
  	change_column :notifications, :checked, :boolean, null: false
  end
end
