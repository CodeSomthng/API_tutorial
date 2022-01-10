require 'rails_helper'

describe 'Books API', type: :request do
  # let!(:book) { create(:book) }
  # let!(:book) { create(:book) }
  

  describe 'GET /api/v1/books' do
    before do
      FactoryBot.create(:book, title: '1984', author: 'George Orwell')
    end

    it 'returns all books' do
      get api_v1_books_path, as: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post '/api/v1/books', params: { book: {title: 'The Martian', author: 'Andy Weir'} }
    }.to change { Book.count }.from(0).to(1)
      

      expect(response).to have_http_status(:created)      
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: 'The Time Machine', author: 'H.G. Wells') }

    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
    }.to change { Book.count }.from(1).to(0)
      

      expect(response).to have_http_status(:no_content)
    end
  end

end
