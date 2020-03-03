# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :user_id, ID, null: false
    field :user_name, String, null: false
    field :user_details, GraphQL::Types::JSON, null: false

    def user_name
      BatchLoader::GraphQL.for(object.user_id).batch do |user_ids, loader|
        User.find(user_ids).each { |user| loader.call(user.id) { user.name } }
      end
    end

    def user_details
      { user_id: object.user.id, user_name: object.user.name }
    end
  end
end
