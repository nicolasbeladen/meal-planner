class MenusController < ApplicationController
  def index
    @menu = current_user.menus.last
    if @menu
      @recipes = @menu.recipes
      @ingredients = @menu.aggregated_ingredients
      @whatsapp_message = build_whatsapp_message(@ingredients)
    else
      @recipes = []
      @ingredients = []
    end
  end

  private

  def build_whatsapp_message(ingredients)
    lines = ingredients.map do |ingredient|
      quantity = if ingredient[:unit].present?
                   "#{ingredient[:quantity].round(1)} #{ingredient[:unit]}"
                 else
                   ingredient[:quantity].to_i.to_s
                 end
      "- #{ingredient[:name].capitalize} x #{quantity}"
    end

    <<~MSG.strip
      *Shopping list from Meal Planner:*
      #{lines.join("\n")}
    MSG
  end
end
