class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer     :genre_id,          null: false
      t.string      :question_name,     null: false
      t.string      :question_content,  null: false, unique: true
      t.string      :tip
      t.string      :model_answer,      null: false
      t.integer     :point,             null: false
      t.references  :user,              null: false, foreign_key: true
      t.timestamps
    end
  end
end
