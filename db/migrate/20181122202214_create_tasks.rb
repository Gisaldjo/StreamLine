class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :group
      t.integer :sort

      t.timestamps
    end
  end
end
