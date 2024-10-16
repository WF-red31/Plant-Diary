class Admin::DashboardsController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!
    
    def index
      @users = User.all
    end
    
    def show
      @user = User.find(params[:id])
      @posts = @user.posts.page(params[:page])
    end
    
    def post_show
      @post = Post.find(params[:id])
    end
    
    def group_index
      @groups = Group.all
    end
    
    def tag_index
      @tags = Tag.all
    end
    
end
