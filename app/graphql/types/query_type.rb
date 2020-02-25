# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    #Get users list
    field :users, [Types::UserType], null: false, description: 'Get List of all users with their books' do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end

    def users(page: nil, limit: nil)
      load_paginated_resource(model: User.name, page: page, limit: limit)
    end

    #Get user details
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    #Get books list
    field :books, [Types::BookType], null: false, description: 'Get List of all books' do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end

    def books(page: nil, limit: nil)
      load_paginated_resource(model: Book.name, page: page, limit: limit)
    end

    #Get book details
    field :book, Types::BookType, null: false, description: 'Get a specific book' do
      argument :id, ID, required: true
    end

    def book(id:)
      Book.find(id)
    end

    private

    def load_paginated_resource(model:, page:, limit:)
      if page.present?
        offset = (page - 1) * (limit || 5)
        model.constantize.offset(offset).limit(limit)
      else
        model.constantize.limit(limit)
      end
    end
  end
end
