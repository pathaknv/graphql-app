module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: 'Get List of all users with their books'
    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end
    def user(id: )
      User.find(id)
    end

    field :books, [Types::BookType], null: false, description: 'Get List of all books'
    def books
      Book.all
    end

    field :book, Types::BookType, null: false, description: 'Get a specific book' do
      argument :id, ID, required: true
    end
    def book(id: )
      Book.find(id)
    end
  end
end
