class ChangeIsCheckedOf < ActiveRecord::Migration[5.2]
  def up
    change_column :notifications, :is_checked, :boolean, default: false
  end

  def down
    change_column :notifications, :is_checked, :boolean, null: false
  end
end
