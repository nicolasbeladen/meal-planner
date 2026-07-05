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
          cooking_time: recipe["cooking_time"],
          steps: recipe["steps"].to_json
        )
        Array(recipe["ingredients"]).each do |ingredient|
          saved_recipe.ingredients.create!(
            name: ingredient["name"],
            quantity: ingredient["quantity"],
            unit: ingredient["unit"]
          )
        end
      end
      @generated_recipes = menu.recipes
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    system_prompt = SYSTEM_PROMPT.dup

    if user_signed_in? && current_user.user_preference
      pref = current_user.user_preference
      system_prompt += "\nUser preferences:"
      system_prompt += "\n- Cooking skill: #{pref.cooking_skill}" if pref.cooking_skill.present?
      system_prompt += "\n- Household size: #{pref.household_size} people" if pref.household_size.present?
      system_prompt += "\n- Max cooking time: #{pref.max_cooking_time} minutes" if pref.max_cooking_time.present?
      if pref.allergies.any?
      system_prompt += "\n- Food allergies: #{pref.allergies.join(', ')}"
      system_prompt += "\nNever suggest recipes containing these allergens or ingredients derived from them."
end
    end

    response = RubyLLM.chat
                      .with_instructions(system_prompt)
                      .with_params(response_format: { type: "json_object" })
                      .ask(prompt)
    JSON.parse(response.content)["recipes"]
  end
end
