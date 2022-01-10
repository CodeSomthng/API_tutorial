require 'rails_helper'

describe 'Books API', type: :request do
  let!(:book) { create(:book) }
  # let!(:book) { create(:book) }
  

  describe 'GET /api/v1/books' do
    it 'returns all books' do

      # FactoryBot.create(:book, title: '1984', author: 'George Orwell')
      # FactoryBot.create(:book, title: 'The Time Machine', author: 'H.G. Wells')
      get '/api/v1/books', as: :json
      byebug

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
