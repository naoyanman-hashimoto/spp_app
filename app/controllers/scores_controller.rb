class ScoresController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :set_question_answer, only: [:index, :new, :create, :show]

  def index
  end

  def new
    @score    = Score.new
  end

  def create
    user = current_user
    @score = Score.new(score_params)
    if @score.valid?
      @score.save

      totalExp = user.experience_point
      point = @question.point * @score.score / 10
      totalExp += point

      user.experience_point = totalExp
      user.update(experience_point: totalExp)
    
      levelSetting = LevelSetting.find_by(level: user.level + 1);
      if levelSetting.thresold <= user.experience_point
        user.level = user.level + 1
        if user.update(level: user.level)
          flash[:notice] = "レベルが上がりました！"

          if user.character == 'カブトムシ'
            if  beetle_evolution = BeetleEvolution.find_by(level: user.level );
              if beetle_evolution.level <= user.level
                user.update(character_name: beetle_evolution.character_name)
                flash[:notice] = "キャラクターが進化しました！！"
              end
            end
          else user.character == 'クワガタムシ'
            if  stag_beetle_evolution = StagBeetleEvolution.find_by(level: user.level );
              if stag_beetle_evolution.level <= user.level
                user.update(character_name: stag_beetle_evolution.character_name)
                flash[:notice] = "キャラクターが進化しました！！"
              end
            end
          end

        end
      end

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
