# frozen_string_literal: true

module Mutations
  module Books
    # Delete Book Mutation
    class DeleteBook < Mutations::BaseMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(params)
        book = Book.find_by(id: params[:id])
        return { message: "Can't find Book" } if book.nil?

        book.destroy
        { message: 'Book deleted!' }
      end
    end
  end
end
