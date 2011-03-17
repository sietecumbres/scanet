class UserMailer < ActionMailer::Base
  default :from => "info@espiral.co"
  default_url_options[:host] = ENV['URL'] || 'localhost:3000'
  
  def verification(user, token)
    @token= token
    @user = user
    mail(:to => user.email, :subject => "#{@user.full_name}, Verifica tu cuenta")
  end
  
end
