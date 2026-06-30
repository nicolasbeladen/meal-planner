class Recipe < ApplicationRecord
  belongs_to :menu
  has_many :ingredients, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
