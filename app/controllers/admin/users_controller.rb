class Admin::UsersController < Admin::BaseController
  include ApplicationHelper
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{full_name(@user)} was successfully deleted."
    redirect_to admin_users_path
  end
end
