class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    @user.step = :create
    
    if @user.save
      UserMailer.verification(@user, @user.verify_token(remote_information)).deliver
      redirect_to dashboard_path
    else
      render :action => :new
    end
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
