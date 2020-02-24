module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :books, [Types::BookType], null: true
    field :books_count, Integer, null: true
    field :first_book, Types::BookType, null: true

    def books_count
      object.books.count
    end

    def first_book
      object.books.first
    end
  end
end
