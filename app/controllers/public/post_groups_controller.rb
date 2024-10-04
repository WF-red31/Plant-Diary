class Public::PostGroupsController < ApplicationController
    before_action :authenticate_user!

    def create
      @post_group = PostGroup.find_or_initialize_by(post_group_params)
      @post = @post_group.post
      if !@post_group.new_record?
        flash[:alert] = "failer"
        redirect_to post_path(@post)
      elsif @post_group.save
        flash[:notice] = "success"
        redirect_to post_path(@post)
      else
        @group = @post_group.group
        flash.now[:alert] = "failed"
        render "public/posts/show"
      end
    end

    def destroy
      @post_group = PostGroup.find_by_id(params[:id])
      @group = @post_group.group
      @post_group.destroy if @post_group
      flash[:notice] = "グループの中から投稿の削除をすることに成功しました。"
      redirect_to group_path(@group)
    end
    
    private
    
    def post_group_params
      params.require(:post_group).permit(:post_id, :group_id)
    end
end
