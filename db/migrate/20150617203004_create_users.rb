# Public: This class generates the users table in the database
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
    end

    add_index :users, :user_name, unique: true
  end
end
