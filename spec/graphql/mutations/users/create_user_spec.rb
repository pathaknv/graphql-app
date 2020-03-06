# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Users::CreateUser do
  let(:create_user_query) do
    <<~GRAPHQL
      mutation($name: String!, $email: String!) {
        createUser(input: { name: $name, email: $email }) {
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

  it 'should create user' do
    user_count = User.count
    variables = { name: Faker::Name.name, email: Faker::Internet.email }
    result = GraphqlAppSchema.execute(
      create_user_query,
      variables: variables
    )['data']['createUser']

    expect(User.count).to eq(user_count + 1)
    expect(result['user']['name']).to eq(variables[:name])
    expect(result['user']['email']).to eq(variables[:email])
    expect(result['errors']).to be_empty
  end

  it 'should fail to create user due to duplicate email' do
    user = create(:user)
    user_count = User.count
    result = GraphqlAppSchema.execute(
      create_user_query,
      variables: { name: Faker::Name.name, email: user.email }
    )['data']['createUser']

    expect(User.count).to eq(user_count)
    expect(result['user']).to be_nil
    expect(result['errors']).to eq(['Email has already been taken'])
  end
end
