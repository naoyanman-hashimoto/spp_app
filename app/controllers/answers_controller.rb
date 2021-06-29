class AnswersController < ApplicationController
  before_action :set_question, only: [:new, :create]
  before_action :move_to_index, only: [:new, :create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.valid?
      @answer.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:answer_content).merge(user_id: current_user.id, question_id: params[:question_id])
  end

  def move_to_index
    redirect_to root_path if current_user.id == @question.user_id
  end

end
