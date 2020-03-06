# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Books::CreateBook do
  let!(:user) { create(:user) }
  let(:create_book_query) do
    <<~GRAPHQL
      mutation createBook($userId: ID!, $title: String!) {
        createBook(input: { userId: $userId, title: $title }) {
          book {
            id
            title
            userId
            userName
          }
          errors
        }
      }
    GRAPHQL
  end

  it 'should create book' do
    book_count = Book.count
    variables = { userId: user.id, title: Faker::Book.title }
    result = GraphqlAppSchema.execute(
      create_book_query,
      variables: variables
    )['data']['createBook']

    expect(Book.count).to eq(book_count + 1)
    expect(result['book']['title']).to eq(variables[:title])
    expect(result['book']['userId']).to eq(variables[:userId].to_s)
    expect(result['errors']).to be_empty
  end

  it 'should fail to create book for duplicate book title' do
    book = create(:book, user_id: user.id)
    book_count = Book.count
    variables = { userId: user.id, title: book.title }
    result = GraphqlAppSchema.execute(
      create_book_query,
      variables: variables
    )['data']['createBook']

    expect(Book.count).to eq(book_count)
    expect(result['user']).to be_nil
    expect(result['errors']).to eq(['Title has already been taken'])
  end
end
