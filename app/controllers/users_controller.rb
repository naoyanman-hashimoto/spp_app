class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @answers = @user.answers.includes(:user)
  end

  # def levelUp
  #   user = User.find(params[:user_id])
  #   question = Question.find(params[:question_id])
  #   totalExp = user.experience_point
  #   totalExp += question.point

  #   user.experience_point = totalExp
  #   user.update(experience_point: totalExp)
  
  #   levelSetting = LevelSetting.find_by(level: user.level + 1);
  
  #   if levelSetting.thresold <= user.experience_point
  #     user.level = user.level + 1
  #     user.update(level: user.level)
  #   end
  #   redirect_to root_path
  # end
end
