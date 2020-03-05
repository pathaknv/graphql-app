# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::DeleteUser do
  let!(:user) { create(:user) }
  let(:delete_user_query) do
    <<~GraphQL
      mutation deleteUser($id: ID!) {
        deleteUser(input: { id: $id }) {
          message
        }
      }
    GraphQL
  end

  it 'should delete user' do
    user_count = User.count
    result = GraphqlAppSchema.execute(
      delete_user_query,
      variables: { id: user.id }
    )['data']['deleteUser']

    expect(User.count).to eq(user_count - 1)
    expect(result['message']).to eq('User and associated books deleted!')
  end
end
