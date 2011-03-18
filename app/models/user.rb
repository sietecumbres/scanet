require 'base64'

class User < ActiveRecord::Base
  
  has_many :logins
  
  validates :first_name, :presence => true, :if => :validate_on_edit?
  validates :last_name, :presence => true, :if => :validate_on_edit?
  validates :username, :presence => true, :uniqueness => true, :length => {:maximum => 12, :minimum => 4}, :if => :validate_on_edit?
  validates :email, :presence => true, :uniqueness => true, :unless => :validate_on_edit?
  validates :password, :presence => true, :length => {:minimum => 6}, :if => :validate_password_on_edit?
  validates_confirmation_of :password, :confirmation => true, :if => :validate_password_on_edit?
  
  attr_reader :password
  attr_accessor :password_confirmation, :step
  
  def validate_password_on_edit?
    (!password_hash.present? || @password.present?) && validate_on_edit?
  end
  
  def validate_on_edit?
    @step == :edit
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def password=(pw)
    @password = pw
    self.password_salt = ActiveSupport::SecureRandom.base64(27)
    self.password_hash = Base64.encode64 OpenSSL::HMAC.digest('SHA256', self.password_salt, pw)
    nil
  end

  def self.from_session(token)
    return if token.blank?
    if login = Login.where(:token => token).first
      return login.user
    end
    return nil
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
