class AddGoogleIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :google_id, :string
  end
end
