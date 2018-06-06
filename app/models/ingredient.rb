class Ingredient < ApplicationRecord
  # model association
  belongs_to :drink

  # validations
  validates_presence_of :description
end
