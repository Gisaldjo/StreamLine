class AddCurrentAndLastLoginToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_login, :datetime
    add_column :users, :last_login, :datetime
  end
end
