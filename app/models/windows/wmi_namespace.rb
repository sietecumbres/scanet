class Windows::WmiNamespace < ActiveRecord::Base
  has_many :classes, :class_name => 'Windows::WmiClass'
  
  validates :name, :presence => true, :uniqueness => true
  
end
