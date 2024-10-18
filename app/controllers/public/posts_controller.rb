class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_matching_login_post, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    #tag_list = params[:post][:tag_id].split(',')
    if @post.save
      flash[:notice] = "新規投稿の作成に成功しました。"
      #@post.save_tags(tag_list)
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.includes(:post_tags)
    @posts = @posts.where('post_tags.tag_id': params[:tag_id]) if params[:tag_id].present?
    @posts = @posts.page(params[:page])
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_group = @post.post_groups.build
    @tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の更新に成功しました。"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿の削除に成功しました。"
    redirect_to posts_path
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :date, :tag_names)
  end
  
  def is_matching_login_post
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user.id == current_user.id
      redirect_to posts_path
    end
  end
  
end

