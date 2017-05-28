class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :set_user, with: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Account created!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render :edit
    end
  end

  private

   def require_user
     redirect_to login_path unless current_user
   end

   def user_params
     params.require(:user).permit(:first_name, :last_name, :email, :password, :profile)
   end

   def set_user
     @user = current_user
   end
end
