# frozen_string_literal: true

module Mutations
  module Books
    # Create Book Mutation
    class CreateBook < Mutations::BaseMutation
      argument :title, String, required: true
      argument :user_id, ID, required: true

      field :book, Types::BookType, null: true
      field :errors, [String], null: false

      def resolve(params)
        book = Book.new(title: params[:title], user_id: params[:user_id])
        if book.save
          { book: book, errors: [] }
        else
          { book: nil, errors: book.errors.full_messages }
        end
      end
    end
  end
end
