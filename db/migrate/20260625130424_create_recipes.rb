class CreateRecipes < ActiveRecord::Migration[8.1]
  def change
    create_table :recipes do |t|
      t.references :menu, null: false, foreign_key: true
      t.string :title
      t.text :steps
      t.string :cooking_difficulty
      t.integer :cooking_time

      t.timestamps
    end
  end
end
