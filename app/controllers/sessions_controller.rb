class SessionsController < ApplicationController
  
  def show
    reset_session
    @user = User.from_session(params[:id])
    if @user.present?
      @user.update_attribute(:verified, true)
      @user.invalidate_token!(params[:id])
      session[:session_token] = @user.login!(remote_information)
      redirect_to edit_user_path(@user)
    else
      render :action => :new
    end
  end
  
  def new
  end
  
  def create
    if (user = User.find_by_identifiers(params[:session][:login])).present?
      if user.password_is?(params[:session][:password])
        reset_session
        session[:session_token] = user.login!(remote_information)
        if user.master_user?
          redirect_to new_user_path
        else
          redirect_to dashboard_path
        end
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
