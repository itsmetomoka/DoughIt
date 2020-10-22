class RenameMaxAtendeesColumnTo < ActiveRecord::Migration[5.2]
  def change
  	rename_column :lessons, :max_atendees, :max_attendees
  end
end
