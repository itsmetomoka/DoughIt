class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.string :name
      t.datetime :event_date
      t.datetime :deadline
      t.integer :max_atendees
      t.integer :category_name

      t.timestamps
    end
  end
end
