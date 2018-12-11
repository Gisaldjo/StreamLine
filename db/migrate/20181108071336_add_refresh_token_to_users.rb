class AddRefreshTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :oauth_refresh_token, :string
  end
end
