class Public::PostGroupsController < ApplicationController
    before_action :authenticate_user!
    
    def destroy
      @post_group = Post_group.find(params[:id])
      @post_group.destroy
      flash[:notice] = "グループの中から投稿の削除をすることに成功しました。"
      redirect_to groups_path
    end
    
end
