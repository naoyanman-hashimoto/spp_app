class CreateEvolutionSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :evolution_settings do |t|
      t.integer    :level,             null: false
      t.string     :character_name,    null: false
      t.timestamps
    end
  end
end
