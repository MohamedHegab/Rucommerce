require 'rails_helper'

RSpec.describe 'Departments API', type: :request do
  # initialize test data 
  let!(:departments) { FactoryBot.create_list(:department, 10) }
  let(:department_id) { departments.first.id }

  # Test suite for GET /departments
  describe 'GET /departments' do
    # make HTTP get request before each example
    before { get '/departments' }

    it 'returns departments' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /departments/:id
  describe 'GET /departments/:id' do
    before { get "/departments/#{department_id}" }

    context 'when the record exists' do
      it 'returns the department' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(department_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:department_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Department/)
      end
    end
  end

  # Test suite for POST /departments
  describe 'POST /departments' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm' } }

    context 'when the request is valid' do
      before do
        post '/departments', params: valid_attributes
      end

      it 'creates a department' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/departments', params: { name: nil } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /departments/:id
  describe 'PUT /departments/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/departments/#{department_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /departments/:id
  describe 'DELETE /departments/:id' do
    before { delete "/departments/#{department_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
