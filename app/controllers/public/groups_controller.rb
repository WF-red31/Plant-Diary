class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_post, only: [:edit, :update, :destroy]
    
  def new
    @group = Group.new
  end
  
  def create
    @group = current_user.groups.build(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "新規グループの作成に成功しました。"
      if params[:post_id].present?
        redirect_to post_path(params[:post_id])
      else
        redirect_to groups_path
      end
    else
      render :new
    end
  end
  
  def index
    @groups = Group.all
  end
  
  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.page(params[:page])
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "グループの更新に成功しました。"
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループの削除に成功しました。"
    redirect_to groups_path
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction)
  end
  
  def is_matching_login_post
    @group = Group.find(params[:id])
    @user = @group.user
    unless @user.id == current_user.id
      redirect_to groups_path
    end
  end
  
end
