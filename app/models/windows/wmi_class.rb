class Windows::WmiClass < ActiveRecord::Base
  belongs_to :namespace, :class_name => 'Windows::WmiNamespace', :foreign_key => 'wmi_namespace_id'
  has_many :properties, :class_name => 'Windows::WmiProperty'
  
  validates :name, :presence => true, :uniqueness => true
end
