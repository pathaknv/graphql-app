# frozen_string_literal: true

module Mutations::Users
  class CreateUser < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(params)
      user = User.new(name: params[:name], email: params[:email])
      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
