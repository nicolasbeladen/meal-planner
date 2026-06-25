class CreateUserPreferences < ActiveRecord::Migration[8.1]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :household_size
      t.integer :max_cooking_time
      t.string :cooking_skill
      t.string :cuisine_types

      t.timestamps
    end
  end
end
