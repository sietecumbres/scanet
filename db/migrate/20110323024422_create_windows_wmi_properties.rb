class CreateWindowsWmiProperties < ActiveRecord::Migration
  def self.up
    create_table :windows_wmi_properties do |t|
      t.integer :wmi_class_id
      t.string :name
      t.string :class_type

      t.timestamps
    end
  end

  def self.down
    drop_table :windows_wmi_properties
  end
end
