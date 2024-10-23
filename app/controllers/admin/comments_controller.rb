class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
    
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_dashboards_path, notice: 'コメントを削除しました。'
  end 
end
