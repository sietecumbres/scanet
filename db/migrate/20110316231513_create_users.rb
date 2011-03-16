class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :password_hash
      t.string :password_salt
      t.string :verification_token
      t.boolean :verified, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
