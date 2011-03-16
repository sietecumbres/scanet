class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.string :token, :null => false
      t.string :ip_address
      t.string :remote_address
      t.string :user_agent
      t.timestamps
    end
  end

  def self.down
    drop_table :logins
  end
end
