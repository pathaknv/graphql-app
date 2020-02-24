module Types
  class QueryType < Types::BaseObject
    #Get users list
    field :users, [Types::UserType], null: false, description: 'Get List of all users with their books' do
      argument :limit, Integer, required: false
    end

    def users(limit: nil)
      User.limit(limit)
    end

    #Get user details
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id: )
      User.find(id)
    end

    #Get books list
    field :books, [Types::BookType], null: false, description: 'Get List of all books' do
      argument :limit, Integer, required: false
    end

    def books(limit: nil)
      Book.limit(limit)
    end

    #Get book details
    field :book, Types::BookType, null: false, description: 'Get a specific book' do
      argument :id, ID, required: true
    end

    def book(id: )
      Book.find(id)
    end
  end
end
