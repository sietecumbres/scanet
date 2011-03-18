class UsersController < ApplicationController
  before_filter :require_current_user
  before_filter :require_admin_user, :except => ['new', 'create']
  
  def new
    @user = User.new
    @user.step = :new
  end
  
  def create
    @user = User.new params[:user]
    @user.step = :new
    
    if @user.save
      UserMailer.verification(@user, @user.verify_token(remote_information)).deliver
      if current_user.master_user?
        @user.update_attribute(:admin, true)
        current_user.destroy
        reset_session
        redirect_to login_path
        return
      end
    end
    render :action => :new
  end
  
  def edit
    @user = User.find(params[:id])
    @user.step = :edit
  end
  
  def update
    @user = User.find(params[:id])
    @user.step = :edit
    params[:user].delete(:password) and params[:user].delete(:password_confirmation) unless params[:user][:password].present?
    if @user.update_attributes(params[:user])
      redirect_to dashboard_path
    else
      render :action => :edit
    end
  end

end
