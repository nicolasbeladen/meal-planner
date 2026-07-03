class Menu < ApplicationRecord
  belongs_to :user
  has_many :recipes

  def aggregated_ingredients
    recipes.includes(:ingredients).flat_map(&:ingredients)
           .group_by { |ingredient| [ingredient.name.strip.downcase, ingredient.unit] }
           .map { |(name, unit), items| { name: name, unit: unit, quantity: items.sum(&:quantity) } }
           .sort_by { |ingredient| ingredient[:name] }
  end
end
