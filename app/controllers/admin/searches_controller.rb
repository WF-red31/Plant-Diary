class Admin::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @users = []
    @posts = []
      if params[:model] == 'post'
        @posts = Post.all
        if params[:keyword].present?
          @posts = @posts.where('title LIKE ?', "%#{params[:keyword]}%")
        end
      elsif params[:model] == 'user'
        @users = User.all
          if params[:keyword].present?
            @users = @users.where('name LIKE ?', "%#{params[:keyword]}%").or(
             @users.where('email LIKE ?', "%#{params[:keyword]}%"))
          end
      end
  end
  
end
