class SessionsController < ApplicationController

  def new
    redirect_to sessions_online_users_path if signed_in?
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user
      sign_in user
      user.update(is_online: true)
      redirect_to sessions_online_users_path
    else
      flash.now[:error] = "Invalid email"
      render 'new'
    end
  end

  def destroy
    user = current_user
    sign_out
    user.update(is_online: false)
    redirect_to root_path
  end

  def online_users
    @users = User.where(is_online: true) 
  end
end
