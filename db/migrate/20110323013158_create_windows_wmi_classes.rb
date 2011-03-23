class CreateWindowsWmiClasses < ActiveRecord::Migration
  def self.up
    create_table :windows_wmi_classes do |t|
      t.integer :wmi_namespace_id
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :windows_wmi_classes
  end
end
