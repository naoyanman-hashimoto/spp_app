class UsersController < ApplicationController
  before_action :move_to_index, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @answers = @user.answers.includes(:user)
    @levelSetting = LevelSetting.find_by(level: current_user.level + 1)
    
    gon.thresold = @levelSetting.thresold
    gon.experience_point = @user.experience_point
  end

  def move_to_index
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to root_path 
    end
  end
end
