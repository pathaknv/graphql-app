# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :user_id, ID, null: false
    field :user_name, String, null: false

    def user_name
      BatchLoader::GraphQL.for(object.user_id).batch do |user_ids, loader|
        User.find(user_ids).each { |user| loader.call(user.id) { user.name } }
      end
    end
  end
end
