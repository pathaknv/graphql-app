# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :delete_user, mutation: Mutations::Users::DeleteUser

    field :create_book, mutation: Mutations::Books::CreateBook
    field :update_book, mutation: Mutations::Books::UpdateBook
    field :delete_book, mutation: Mutations::Books::DeleteBook
  end
end
