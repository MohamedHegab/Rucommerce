require 'rails_helper'

RSpec.describe 'promotions API', type: :request do
  # initialize test data 
  let!(:promotions) { FactoryBot.create_list(:promotion, 10) }
  let(:promotion_id) { promotions.first.id }

  # Test suite for GET /promotions
  describe 'GET /promotions' do
    # make HTTP get request before each example
    before { get '/promotions' }

    it 'returns promotions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /promotions/:id
  describe 'GET /promotions/:id' do
    before { get "/promotions/#{promotion_id}" }

    context 'when the record exists' do
      it 'returns the promotion' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(promotion_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:promotion_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Promotion/)
      end
    end
  end

  # Test suite for POST /promotions
  describe 'POST /promotions' do
    # valid payload
    let(:valid_attributes) { { start_date: Date.today, end_date: Date.today + 1, code: 'Elm32', percent: 50 } }

    context 'when the request is valid' do
      before do
        post '/promotions', params: valid_attributes
      end

      it 'creates a promotion' do
        expect(json['code']).to eq('Elm32')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/promotions', params: { start_date: Date.today, end_date: Date.today + 1, percent: 50 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Code can't be blank/)
      end
    end
  end

  # Test suite for PUT /promotions/:id
  describe 'PUT /promotions/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/promotions/#{promotion_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /promotions/:id
  describe 'DELETE /promotions/:id' do
    before { delete "/promotions/#{promotion_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
