require 'rails_helper'

RSpec.describe 'Products API' do
  # Initialize the test data
  let!(:department) { FactoryBot.create(:department) }
  let!(:products) { FactoryBot.create_list(:product, 20, department_id: department.id) }
  let(:department_id) { department.id }
  let(:id) { products.first.id }

  # Test suite for GET /departments/:department_id/products
  describe 'GET /departments/:department_id/products' do
    before { get "/departments/#{department_id}/products" }

    context 'when department exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all department products' do
        expect(json.size).to eq(20)
      end
    end

    context 'when department does not exist' do
      let(:department_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Department/)
      end
    end
  end

  # Test suite for GET /departments/:department_id/products/:id
  describe 'GET /departments/:department_id/products/:id' do
    before { get "/departments/#{department_id}/products/#{id}" }

    context 'when department Product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the Product' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when department Product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for PUT /departments/:department_id/products
  describe 'POST /departments/:department_id/products' do
    let(:valid_attributes) { { name: 'Practical Granite Shirt', price: 22.2 } }

    context 'when request attributes are valid' do
      before { post "/departments/#{department_id}/products", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/departments/#{department_id}/products", params: {price: 22.2} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /departments/:department_id/products/:id
  describe 'PUT /departments/:department_id/products/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/departments/#{department_id}/products/#{id}", params: valid_attributes }

    context 'when Product exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the Product' do
        updated_Product = Product.find(id)
        expect(updated_Product.name).to match(/Mozart/)
      end
    end

    context 'when the Product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for DELETE /departments/:id
  describe 'DELETE /departments/:id' do
    before { delete "/departments/#{department_id}/products/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
