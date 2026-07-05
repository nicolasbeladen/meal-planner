# app/helpers/ingredients_helper.rb
module IngredientsHelper
  def ingredient_quantity(ingredient)
    quantity = ActiveSupport::NumberHelper.number_to_rounded(
      ingredient[:quantity],
      precision: 1,
      strip_insignificant_zeros: true
    )
    [quantity, ingredient[:unit]].compact_blank.join(" ")
  end

  def whatsapp_message(ingredients)
    lines = ingredients.map do |ingredient|
      "- #{ingredient[:name].capitalize} x #{ingredient_quantity(ingredient)}"
    end

    <<~MSG.strip
      *Shopping list from Meal Planner:*
      #{lines.join("\n")}
    MSG
  end
end
