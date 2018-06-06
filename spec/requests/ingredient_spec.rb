require 'rails_helper'

RSpec.describe 'Ingredients API' do
  # Initialize test data
  let!(:drink) { create(:drink) }
  let!(:ingredients) { create_list(:ingredient, 20, drink_id: drink.id) }
  let(:drink_id) { drink.id }
  let(:id) { ingredients.first.id }

  # Test suite for GET /drinks/:drink_id/ingredients
  describe 'GET /drinks/:drink_id/ingredients' do
    before { get "/drinks/#{drink_id}/ingredients" }

    context 'when drink exists' do
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all ingredients' do
        expect(json.size).to eq(20)
      end
    end

    context 'when drink does not exist' do
      let(:drink_id) { 0 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Couldn't find Drink/)
      end
    end
  end

  # Test suite for GET /drinks/:drink_id/ingredients/:id
  describe 'GET /drinks/:drink_id/ingredients/:id' do
    before { get "/drinks/#{drink_id}/ingredients/#{id}" }

    context 'when drink ingredient exists' do
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return the correct ingredient' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when drink ingredient does not exist' do
      let(:id) { 0 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  # Test suite for POST /drinks/:drink_id/ingredients
  describe 'POST /drinks/:drink_id/ingredients' do
    let(:valid_attributes) { { description: '2oz Gin' } }

    context 'when request attributes are valid' do
      before { post "/drinks/#{drink_id}/ingredients", params: valid_attributes }

      it 'should return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are invalid' do
      before { post "/drinks/#{drink_id}/ingredients", params: {} }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /drinks/:drink_id/ingredients/:id
  describe 'PUT /drinks/:drink_id/ingredients/:id' do
    let(:valid_attributes) { { description: '2oz Gin' } }

    before { put "/drinks/#{drink_id}/ingredients/#{id}", params: valid_attributes }

    context 'when ingredient exists' do
      it 'should return status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'should update ingredient' do
        updated_item = Ingredient.find(id)
        expect(updated_item.description).to match(/2oz Gin/)
      end
    end

    context 'when ingredient does not exist' do
      let(:id) { 0 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  # Test suite for DELETE /drinks/:drink_id/ingredients/:id
  describe 'DELETE /drinks/:drink_id/ingredients/:id' do
    before { delete "/drinks/#{drink_id}/ingredients/#{id}" }

    it 'should return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end