class UserMailer < ActionMailer::Base
  default :from => "info@espiral.co"
  default_url_options[:host] = ENV['URL'] || 'localhost:3000'
  
  def verification(user, token)
    @token = token
    @user = user
    mail(:to => user.email, :subject => "Verifica tu cuenta")
  end
  
  def forgot_password(user, token)
    @token = token
    @user = user
    mail(:to => user.email, :subject => "Recupera tu password")
  end
  
end
