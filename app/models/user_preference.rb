class UserPreference < ApplicationRecord
  belongs_to :user

  validates :household_size, numericality: { greater_than: 0, only_integer: true }, allow_nil: true
  validates :max_cooking_time, numericality: { greater_than: 0, only_integer: true }, allow_nil: true
end
