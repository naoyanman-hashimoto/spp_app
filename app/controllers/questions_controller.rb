class QuestionsController < ApplicationController
  def index
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path
    else
      render :new
    end
  end

end


private

def question_params
  params.require(:question).permit(:genre_id, :question_name, :question_content, :tip, :model_answer, :point).merge(user_id: current_user.id)
end
