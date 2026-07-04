class MenusController < ApplicationController
  include IngredientsHelper

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
      "- #{ingredient[:name].capitalize} x #{ingredient_quantity(ingredient)}"
    end

    <<~MSG.strip
      *Shopping list from Meal Planner:*
      #{lines.join("\n")}
    MSG
  end
end
