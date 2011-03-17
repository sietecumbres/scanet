require 'base64'

class User < ActiveRecord::Base
  
  has_many :logins
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :username, :presence => true, :uniqueness => true, :length => {:maximum => 12, :minimum => 4}
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true, :length => {:minimum => 6}
  
  attr_reader :password
  attr_accessor :password_confirmation
  
  def password=(pw)
    @password = pw
    self.password_salt = ActiveSupport::SecureRandom.base64(27)
    self.password_hash = Base64.encode64 OpenSSL::HMAC.digest('SHA256', self.password_salt, pw)
    nil
  end

  def self.from_session(token)
    return if token.blank?
    login.user if login = Login.where(:token => token).first
  end

  def password_is?(pw)
    Base64.encode64(OpenSSL::HMAC.digest('SHA256', self.password_salt, pw)) == self.password_hash
  end

  def password_was?(pw)
    Base64.encode64(OpenSSL::HMAC.digest('SHA256', self.password_salt_was, pw)) == self.password_hash_was
  end

  def login!(data)
    while token = ActiveSupport::SecureRandom.base64(21)
      unless self.class.from_session(token).present?
        data[:token] = token
        self.logins.create data
        break
      end
    end
    self.shift_tokens!
    self.save
    token
  end

  def verify_token(data = {})
    token = ActiveSupport::SecureRandom.hex(20)
    data[:token] = token
    self.logins.create data
    self.shift_tokens!
    self.save
    token
  end

  def shift_tokens!
    self.logins.first.destroy while self.logins.count > 10
  end

  def invalidate_token!(token)
    login = self.logins.where(:token => token).first
    login.destroy if login.present?
  end
  
  def self.find_by_identifiers(eu)
    where("username = ? OR email = ?", eu, eu).first
  end
  
end
