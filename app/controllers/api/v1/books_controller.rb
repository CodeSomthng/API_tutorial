module Api
  module V1
    class BooksController < ApplicationController

      def index
        books = Book.all

        render json: BooksRepresenter.new(books).as_json
      end
      
      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))

        if book.save
          # status code 201 - record is successfully created
          render json: BookRepresenter.new(book).as_json, status: :created
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

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:title)
      end
    end
  end
end
