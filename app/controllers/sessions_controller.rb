class SessionsController < ApplicationController
  def new
    # binding.pry
    redirect_to user_path(current_user) if current_user
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in!"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    reset_session
    flash[:success] = "Successfully logged out!"
    # binding.pry
    redirect_to login_path
  end
end
