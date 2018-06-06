require 'rails_helper'

# Test suite for the Ingredient model
RSpec.describe Ingredient, type: :model do
  # Association test
  # ensure an ingredient belongs to a single Drink record
  it { should belong_to(:drink) }

  # Validation test
  # ensure column description is present before saving
  it { should validate_presence_of(:description) }
end
