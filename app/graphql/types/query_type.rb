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
  end
end
