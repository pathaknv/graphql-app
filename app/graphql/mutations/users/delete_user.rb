# frozen_string_literal: true

module Mutations
  module Users
    # Delete User Mutation
    class DeleteUser < Mutations::BaseMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(params)
        user = User.find_by(id: params[:id])
        return { message: "Can't find User" } if user.nil?

        user.destroy
        { message: 'User and associated books deleted!' }
      end
    end
  end
end
