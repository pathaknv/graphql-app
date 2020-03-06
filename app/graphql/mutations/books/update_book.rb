# frozen_string_literal: true

module Mutations
  module Books
    # Update Book Mutation
    class UpdateBook < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :title, String, required: false

      field :book, Types::BookType, null: true
      field :errors, [String], null: false

      def resolve(params)
        book = Book.find_by(id: params[:id])
        return { book: nil, errors: ["Can't find Book"] } if book.nil?

        if book.update(params)
          { book: book, errors: [] }
        else
          { book: book, errors: book.errors.full_messages }
        end
      end
    end
  end
end
