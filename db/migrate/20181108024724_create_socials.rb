class CreateSocials < ActiveRecord::Migration[5.0]
  def change
    create_table :socials do |t|
      t.integer :kind
      t.string :username, default: ""
      t.text :uid
      t.text :token
      t.datetime :token_expires
      t.datetime :verified
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :socials, :username
    add_index :socials, :kind
    add_index :socials, :uid
  end
end
