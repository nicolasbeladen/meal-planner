class MenusController < ApplicationController
  def index
    @menu = current_user.menus.last
    if @menu
      @recipes = @menu.recipes
      @ingredients = @menu.aggregated_ingredients
    else
      @recipes = []
      @ingredients = []
    end
  end
end
