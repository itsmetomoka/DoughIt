class AddImageFileNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_file_name, :string
  end
end
