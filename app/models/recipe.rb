class Recipe < ApplicationRecord
  belongs_to :menu
  has_many :ingredients
  has_many :favorites, dependent: :destroy
end
