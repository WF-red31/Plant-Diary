class Admin::DashboardsController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!
    
    def index
      @users = User.all
    end
    
    def show
      @user = User.find(params[:id])
    end
    
end
