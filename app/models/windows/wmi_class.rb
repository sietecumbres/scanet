class Windows::WmiClass < ActiveRecord::Base
  belongs_to :namespace, :class_name => 'Windows::WmiNamespace', :foreign_key => 'wmi_namespace_id'
  
  validates :name, :presence => true, :uniqueness => true
end
