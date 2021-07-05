class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @answers = @user.answers.includes(:user)
  end
end
