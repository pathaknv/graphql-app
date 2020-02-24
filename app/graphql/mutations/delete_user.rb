# frozen_string_literal: true

module Mutations
  class DeleteUser < Mutations::BaseMutation
    argument :id, ID, required: true

    field :message, String, null: false

    def resolve(params)
      user = User.find_by_id(params[:id])
      return { message: "Can't find User" } if user.nil?

      if user.destroy
        { message: 'User and associated books deleted!' }
      else
        { message: user.errors.full_messages }
      end
    end
  end
end
