class CreateWindowsWmiNamespaces < ActiveRecord::Migration
  def self.up
    create_table :windows_wmi_namespaces do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :windows_wmi_namespaces
  end
end
