class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  def new
  end

  def create
    prompt = params[:recipe_request][:prompt]
    @generated_recipes = generate_recipes(prompt)

    if user_signed_in?
      menu = current_user.menus.create!(prompt: prompt)

      @generated_recipes.each do |recipe|
        saved_recipe = menu.recipes.create!(
          title: recipe["title"],
          cooking_difficulty: recipe["cooking_difficulty"],
          cooking_time: recipe["cooking_time"]
        )
      Array(recipe["ingredients"]).each do |ingredient|
    saved_recipe.ingredients.create!(
      name: ingredient["name"],
      quantity: ingredient["quantity"],
      unit: ingredient["unit"]
    )
      end
      end
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  SYSTEM_PROMPT = <<~PROMPT
    You are a chef assistant for a weekly meal planner.
    Generate exactly 3 distinct, healthy, realistic recipes from the user's brief.
    Default to 2 servings if unspecified.
    Reply with ONLY a JSON object (no markdown) with this shape:
    { "recipes": [ { "title": "string", "cooking_difficulty": 1, "cooking_time": 20,
      "ingredients": [ { "name": "string", "quantity": 200, "unit": "g" } ],
      "steps": ["string"] } ] }
  PROMPT

  def generate_recipes(prompt)
    response = RubyLLM.chat
                      .with_instructions(SYSTEM_PROMPT)
                      .with_params(response_format: { type: "json_object" })
                      .ask(prompt)
    JSON.parse(response.content)["recipes"]
  end
end
