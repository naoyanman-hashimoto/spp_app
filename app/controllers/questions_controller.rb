class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :select_genre, only: [:index, :genre]
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :genre, :new, :create, :destroy ]

  def index
    @results = @p.result
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

  def genre
    @results = @p.result
    genre_id = params[:q][:genre_id_eq]
    @genre = Genre.find_by(id: genre_id)
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to root_path
    end
  end

  private

  def question_params
    params.require(:question).permit(:genre_id, :question_name, :question_content, :tip, :model_answer,
                                     :point).merge(user_id: current_user.id)
  end

  def select_genre
    @p = Question.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def move_to_index
    question = Question.find(params[:id])
    unless current_user.id == question.user_id
      redirect_to action: :index
    end
  end

  def set_question
    @question = Question.find(params[:id])
  end

end
