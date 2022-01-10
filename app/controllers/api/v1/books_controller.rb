module Api
  module V1
    class BooksController < ApplicationController

      def index
        books = Book.all

        render json: BooksRepresenter.new(books).as_json
      end
      
      def create
        # Initialize a record but not save to database yet
        book = Book.new(book_params)
        if book.save
          # status code 201 - record is successfully created
          render json: book, status: :created
        else
          # status code 422 - unprocessable_entity, not create a book
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!

        head :no_content
      end

      private

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
