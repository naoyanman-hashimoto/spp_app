class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @answers = @user.answers.includes(:user)
    @levelSetting = LevelSetting.find_by(level: current_user.level + 1)
    
    gon.thresold = @levelSetting.thresold
    gon.experience_point = @user.experience_point
  end
end
