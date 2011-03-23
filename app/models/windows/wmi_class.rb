class Windows::WmiClass < ActiveRecord::Base
  belongs_to :wmi_namespace, :class_name => 'windows/wmi_namespace'
  
  validates :name, :presence => true, :uniqueness => true
end
