class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.full_name} was successfully deleted."
    redirect_to admin_users_path
  end
end
