class UsersController < ApplicationController
  def index
    @users = User.all
    
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールの更新に成功しました。"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを削除しました。"
    redirect_to new_user_registration_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
end
