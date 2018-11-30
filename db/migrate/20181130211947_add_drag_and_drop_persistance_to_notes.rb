class AddDragAndDropPersistanceToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :x, :int
    add_column :notes, :y, :int
  end
end
