class Windows::WmiProperty < ActiveRecord::Base
  belongs_to :klass, :class_name => 'Windows::WmiClass', :foreign_key => 'wmi_class_id'
  
  VALID_TYPES = [['HARDWARE', 'hardware'], ['SOFTWARE', 'software']]
  
  validates :name, :presence => true, :uniqueness => true
  validates :class_type, :presence => true, :inclusion => { :in => ['hardware', 'software'] }
  
end
