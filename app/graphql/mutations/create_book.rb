module Mutations
  class CreateBook < Mutations::BaseMutation
    argument :title, String, required: true
    argument :user_id, ID, required: true

    field :book, Types::BookType, null: true
    field :errors, [String], null: false

    def resolve(title: ,user_id: )
      book = Book.new(title: title, user_id: user_id)
      if book.save
        { book: book, errors: [] }
      else
        { book: nil, errors: book.errors.full_messages }
      end
    end

  end
end
