class AddPopulatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :populated, :boolean
  end
end
