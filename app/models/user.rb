class User < ActiveRecord::Base
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :username, :presence => true, :uniqueness => true, :length => {:maximum => 12, :minimum => 4}
  validates :email, :presence => true, :uniqueness => true
  
end
