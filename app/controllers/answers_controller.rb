class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer_content).merge(user_id: current_user.id, question_id: params[:question_id])
  end
end
