# frozen_string_literal: true

module Mutations
  class DeleteBook < Mutations::BaseMutation
    argument :id, ID, required: true

    field :message, String, null: false

    def resolve(params)
      book = Book.find_by_id(params[:id])
      return { message: "Can't find Book" } if book.nil?

      if book.destroy
        { message: 'Book deleted!' }
      else
        { message: book.errors.full_messages }
      end
    end
  end
end
