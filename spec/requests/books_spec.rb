require 'rails_helper'

RSpec.describe "Books", type: :request do
  let!(:books) { create_list(:book, 2) }
  let(:book_id) { books.first.id }

  describe "GET /api/v1/books" do
    before { get '/api/v1/books' }
    it 'should return all books' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /apu/v1/books/:id' do
    before { get "/api/v1/books/#{book_id}" }
    context 'when book exists' do
      it 'should returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'should returns the book item' do
        expect(json['id']).to eq(book_id)
      end
    end
    context 'when book does not exist' do
      let(:book_id) { 0 }
      it 'should returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/books' do
    let(:author) { Author.create(firstName: "John", lastName: "Doe", birthday: '03-03-2000', nacionality: 'S') }
    let(:genre) { Genre.create(name: "John") }
    let(:valid_attributes) do
      { title: 'Book', description: 'This is a book', author_id: author.id, genre_id: genre.id, published_date: Date.today, in_stock: 10, available: true }
    end
    let(:invalid_attributes) do
      { book: '' }
    end
    context 'when request attributes are valid' do
      before { post '/api/v1/books', params: { book: valid_attributes } }
      it 'should returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/api/v1/books', params: {} }
      it 'should returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
    context 'when request has invalid params' do
      before { post '/api/v1/books', params: { book: invalid_attributes } }
      it 'should returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/books/:id' do
    let(:valid_attributes) { { title: 'Saffron Swords' } }
    before { put "/api/v1/books/#{book_id}", params: { book: valid_attributes } }
    context 'when book exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'updates the book' do
        updated_item = Book.find(book_id)
        expect(updated_item.title).to match(/Saffron Swords/)
      end
    end
    context 'when the book does not exist' do
      let(:book_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /api/v1/books/:id' do
    before { delete "/api/v1/books/#{book_id}" }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
