class CreateMenus < ActiveRecord::Migration[8.1]
  def change
    create_table :menus do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :number_meals
      t.text :prompt

      t.timestamps
    end
  end
end
