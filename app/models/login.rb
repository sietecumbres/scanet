class Login < ActiveRecord::Base
  
  belongs_to :user
  
  validates :token, :presence => true, :length => {:minimum => 20}
  
end
