class ScoresController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :set_question_answer, only: [:index, :new, :create, :show]

  def index
  end

  def new
    @score    = Score.new
  end

  def create
    @score = Score.new(score_params)
    if @score.valid?
      @score.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @score = Score.find(params[:id])
  end

  private

  def set_question_answer
    @question = Question.find(params[:question_id])
    @answer   = Answer.find(params[:answer_id])
  end

  def score_params
    params.require(:score).permit(:score).merge(user_id: current_user.id, answer_id: params[:answer_id] )
  end

end
