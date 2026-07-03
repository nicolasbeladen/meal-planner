class FavoritesController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    current_user.favorites.find_or_create_by!(recipe: recipe)

    redirect_to menus_path, notice: "Added to favorites."
  end
end
