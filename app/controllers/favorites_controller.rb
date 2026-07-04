class FavoritesController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    current_user.favorites.find_or_create_by!(recipe: recipe)

    redirect_to menus_path, notice: "Added to favorites.", status: :see_other
  end

  def index
    @favorites = current_user.favorites.includes(recipe: :ingredients)
    @recipes = @favorites.map(&:recipe)
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.find_by!(recipe: recipe)
    favorite.destroy

    redirect_back fallback_location: favorites_path,
                  notice: "Removed from favorites.",
                  status: :see_other
  end
end
