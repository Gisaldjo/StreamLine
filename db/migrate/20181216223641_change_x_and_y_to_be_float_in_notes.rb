class ChangeXAndYToBeFloatInNotes < ActiveRecord::Migration[5.2]
  def change
    change_column :notes, :x, :float
    change_column :notes, :y, :float
  end
end
