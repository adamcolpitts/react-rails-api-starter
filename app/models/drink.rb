class Drink < ApplicationRecord
  # model associations
  has_many :ingredients, dependent: :destroy

  # validations
  validates_presence_of :title, :description, :steps, :source

end
