require 'rails_helper'

RSpec.describe "Genres", type: :request do
  let!(:genres) { create_list(:genre, 2) }
  let(:genre_id) { genres.first.id }

  describe "GET /api/v1/genres" do
    before { get '/api/v1/genres' }
    it 'should return all genres' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /apu/v1/genres/:id' do
    before { get "/api/v1/genres/#{genre_id}" }
    context 'when genre exists' do
      it 'should returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'should returns the genre item' do
        expect(json['id']).to eq(genre_id)
      end
    end
    context 'when genre does not exist' do
      let(:genre_id) { 0 }
      it 'should returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/genres' do
    let(:valid_attributes) do
      { name: 'Book', description: 'This is a book' }
    end
    let(:invalid_attributes) do
      { book: '' }
    end
    context 'when request attributes are valid' do
      before { post '/api/v1/genres', params: { genre: valid_attributes } }
      it 'should returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/api/v1/genres', params: {} }
      it 'should returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
    context 'when request has invalid params' do
      before { post '/api/v1/genres', params: { genre: invalid_attributes } }
      it 'should returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/genres/:id' do
    let(:valid_attributes) { { name: 'Saffron Swords' } }
    before { put "/api/v1/genres/#{genre_id}", params: { genre: valid_attributes } }
    context 'when genre exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'updates the genre' do
        updated_item = Genre.find(genre_id)
        expect(updated_item.name).to match(/Saffron Swords/)
      end
    end
    context 'when the genre does not exist' do
      let(:genre_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /api/v1/genres/:id' do
    before { delete "/api/v1/genres/#{genre_id}" }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
