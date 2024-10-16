class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tag_index_path, notice: 'タグを削除しました。'
  end
end
