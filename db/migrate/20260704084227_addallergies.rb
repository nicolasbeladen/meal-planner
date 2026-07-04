class Addallergies < ActiveRecord::Migration[8.1]
  def change
        add_column :user_preferences, :allergies, :string, array: true, default: []
  end
end
