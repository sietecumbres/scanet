class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  
  helper_method :current_user, :logged_in?, :logged_out?
  
  def set_locale
    I18n.locale = params[:locale]
  end
  
  protected
    def current_user
      @current_user ||= User.from_session(session[:session_token])
    end

    def logged_in?
      !!current_user
    end

    def logged_out?
      !current_user
    end
    
    def remote_information
      {
        :user_agent => request.user_agent, 
        :ip_address => request.remote_ip,
        :remote_address => request.remote_addr
      }
    end
    
    def require_current_user
      return true if logged_in?
      redirect_to login_path, :notice => 'You must be logged in to take that action.' unless request.xhr?
    end
end
