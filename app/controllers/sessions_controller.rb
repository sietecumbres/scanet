class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    if (user = User.find_by_identifiers(params[:session][:login])).present?
      if user.password_is?(params[:session][:password])
        reset_session
        session[:session_token] = user.login!(remote_information)
        redirect_to dashboard_path
        return 
      end
    end
    flash[:notice] = 'User does not exist.'
    render :action => :new
  end
  
  def destroy
    current_user.invalidate_token!(session[:session_token])
    reset_session
    redirect_to root_path
  end

end
