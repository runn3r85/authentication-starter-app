class UserSessionsController < ApplicationController
  def new
    # if current_user redirect
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Thank you for signing in!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was a problem signing in. Please check your email and password."
      render action: 'new'
    end
  end
end
