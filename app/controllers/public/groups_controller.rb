class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
    
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "新規グループの作成に成功しました。"
      redirect_to groups_path
    else
      render :new
    end
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction)
  end
  
end
