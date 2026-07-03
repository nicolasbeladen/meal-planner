class FavoritesController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    current_user.favorites.find_or_create_by!(recipe: recipe)

    redirect_to menus_path, notice: "Added to favorites.", status: :see_other
  end

  def index
    @menu = current_user.menus.includes(recipes: :ingredients).last
    @recipes = @menu ? @menu.recipes : []
    @favorites_count = current_user.favorites.count
  end
end
