require 'rails_helper'

describe 'Books API', type: :request do
  # let!(:book) { create(:book) }
  # let!(:book) { create(:book) }
  

  describe 'GET /api/v1/books' do
    # before do
    #   author = FactoryBot.create(:author, first_name: "George", last_name: "Orwell", age: 99)
    #   FactoryBot.create(:book, title: '1984', author_id: author.id)
    # end
    let!(:author) { FactoryBot.create(:author, first_name: "George", last_name: "Orwell", age: 99) }
    let!(:book) { FactoryBot.create(:book, title: '1984', author_id: author.id) }

    it 'returns all books' do
      get api_v1_books_path
      
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            "id": 1,
            "title": '1984',
            "author_name": 'George Orwell',
            "author_age": 99
          }
        ]
      )
    end

    it 'returns a subset of books based on pagination' do

      get api_v1_books_path, params: { limit: 1 }

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            "id": 1,
            "title": '1984',
            "author_name": 'George Orwell',
            "author_age": 99
          }
        ]
      )
    end

    it 'returns a subset of books based on limit and offset' do
      get api_v1_books_path, params: { limit: 1, offset: 0 }

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            "id": 1,
            "title": '1984',
            "author_name": 'George Orwell',
            "author_age": 99
          }
        ]
      )
    end

  end

  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post '/api/v1/books', params: { 
          book: {title: 'The Martian'},
          author: {first_name: 'Andy', last_name: 'Weir', age: '50'}
        }
      }.to change { Book.count }.from(0).to(1)


      expect(response).to have_http_status(:created)  
      expect(Author.count).to eq(1)
      expect(response_body).to eq(
        {
          "id": 1,
          "title": 'The Martian',
          "author_name": 'Andy Weir',
          "author_age": 50
        }
      )
    end
  end

  describe 'DELETE /books/:id' do
    
    let!(:author) { create(:author)}
    let!(:book) { create(:book, author: author) }

    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
    }.to change { Book.count }.from(1).to(0)
      

      expect(response).to have_http_status(:no_content)
    end
  end

end
