class CreateStagBeetleEvolutions < ActiveRecord::Migration[6.0]
  def change
    create_table :stag_beetle_evolutions do |t|
      t.integer    :level,             null: false
      t.string     :character_name,    null: false
      t.timestamps
    end
  end
end
