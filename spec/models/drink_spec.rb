require 'rails_helper'

# Test suite for the Drink model
RSpec.describe Drink, type: :model do
  # Association test
  # ensure Drink model has a 1:m relationship with the Ingredient model
  it { should have_many(:ingredients).dependent(:destroy) }

  # Validation tests
  # ensure columns title, descriptions, steps, and source are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:steps) }
  it { should validate_presence_of(:source) }

end
