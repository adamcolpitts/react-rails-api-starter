require 'rails_helper'

RSpec.describe 'Drinks API', type: :request do
  # init test data
  let!(:drinks) { create_list(:drink, 10) }
  let(:drink_id) { drinks.first.id }

  # Test suite for GET /drinks
  describe 'GET /drinks' do
    # make HTTP get request before each example
    before { get '/drinks' }

    it 'should return drinks' do
      # note 'json' is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /drinks/:id
  describe 'GET /drinks/:id' do
    before { get "/drinks/#{drink_id}" }

    context 'when the record exists' do
      it 'should return the correct drink' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(drink_id)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:drink_id) { 100 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Couldn't find Drink/)
      end
    end
  end

  # Test suite for POST /drinks
  describe 'POST /drinks' do
    # valid payload
    let(:valid_attributes) {{
        title: 'Tom Collins',
        description: 'A cocktail made from gin, lemon juice, sugar, and carbonated water.',
        steps: 'steps test',
        source: 'source test'
    }}

    context 'when the request is valid' do
      before { post '/drinks', params: valid_attributes }

      it 'should create a new drink' do
        expect(json['title']).to eq('Tom Collins')
      end

      it 'should return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/drinks', params: { title: 'Foobar' } }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'should return a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /drinks/:id
  describe 'PUT /drinks/:id' do
    let(:valid_attributes) { { title: 'Old Fasioned' } }

    context 'when the record exists' do
      before { put "/drinks/#{drink_id}", params: valid_attributes }

      it 'should update the record' do
        expect(response.body).to be_empty
      end

      it 'should return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /drinks/:id
  describe 'DELETE /drinks/:id' do
    before { delete "/drinks/#{drink_id}" }

    it 'should return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end