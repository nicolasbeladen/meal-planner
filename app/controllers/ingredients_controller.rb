class IngredientsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.new(ingredient_params)

    if @ingredient.save
      redirect_to menus_path, notice: "Ingredient saved successfully."
    else
      redirect_to menus_path, alert: "Ingredient could not be saved."
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :unit)
  end
end
