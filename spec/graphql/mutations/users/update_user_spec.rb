# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::UpdateUser do
  let(:update_user_query) do
    <<~GRAPHQL
      mutation updateUser($id: ID!, $name: String, $email: String) {
        updateUser(input: { id: $id, name: $name, email: $email }) {
          user {
            id
            name
            email
          }
          errors
        }
      }
    GRAPHQL
  end

  before { @user = create(:user) }

  it 'should update user' do
    user_count = User.count
    variables = { id: @user.id, email: Faker::Internet.email }
    result = GraphqlAppSchema.execute(
      update_user_query,
      variables: variables
    )['data']['updateUser']

    expect(User.count).to eq(user_count)
    expect(result['user']['name']).to eq(@user.name)
    expect(result['user']['email']).to eq(variables[:email])
    expect(result['errors']).to be_empty
  end

  it 'should fail to update user due to duplicate email' do
    user = create(:user)
    user_count = User.count
    variables = { id: @user.id, email: user.email }
    result = GraphqlAppSchema.execute(
      update_user_query,
      variables: variables
    )['data']['updateUser']

    expect(User.count).to eq(user_count)
    expect(result['errors']).to eq(['Email has already been taken'])
  end
end
