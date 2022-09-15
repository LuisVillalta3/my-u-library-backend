require 'rails_helper'

RSpec.describe "Authors", type: :request do
  # initialize test data
  let!(:authors) { create_list(:author, 5) }
  let(:author_id) { authors.first.id }

  describe "GET /api/v1/author" do
    before { get '/api/v1/author' }
    it 'should return all authors' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /author/:id' do
    before { get "/api/v1/author/#{author_id}" }
    context 'when author exists' do
      it 'should returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'should returns the author item' do
        expect(json['id']).to eq(author_id)
      end
    end
    context 'when author does not exist' do
      let(:author_id) { 0 }
      it 'should returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/author' do
    let(:valid_attributes) do
      { firstName: 'Luis', lastName: 'Villalta', birthday: '03-03-2000', nacionality: 'Salvadorian' }
    end
    let(:invalid_attributes) do
      { firstName: '', lastName: '', birthday: '', nacionality: '' }
    end
    context 'when request attributes are valid' do
      before { post '/api/v1/author', params: { author: valid_attributes } }
      it 'should returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/api/v1/author', params: {} }
      it 'should returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
    context 'when request has invalid params' do
      before { post '/api/v1/author', params: { author: invalid_attributes } }
      it 'should returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/author/:id' do
    let(:valid_attributes) { { firstName: 'Saffron Swords' } }
    before { put "/api/v1/author/#{author_id}", params: { author: valid_attributes } }
    context 'when author exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'updates the author' do
        updated_item = Author.find(author_id)
        expect(updated_item.firstName).to match(/Saffron Swords/)
      end
    end
    context 'when the author does not exist' do
      let(:author_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /api/v1/author/:id' do
    before { delete "/api/v1/author/#{author_id}" }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
