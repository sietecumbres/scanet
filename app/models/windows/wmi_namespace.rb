class Windows::WmiNamespace < ActiveRecord::Base
  has_many :wmi_classes, :class_name => 'windows/wmi_class'
  
  validates :name, :presence => true, :uniqueness => true
  
end
