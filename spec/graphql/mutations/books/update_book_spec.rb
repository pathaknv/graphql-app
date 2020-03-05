# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Books::UpdateBook do
  let(:user) { create(:user) }
  let!(:book) { create(:book, user_id: user.id) }
  let(:update_book_query) do
    <<~GraphQL
      mutation updateBook($id: ID!, $title: String) {
        updateBook(input: { id: $id, title: $title }) {
          book {
            id
            title
            userId
            userName
          }
          errors
        }
      }
    GraphQL
  end

  it 'should update book' do
    book_count = Book.count
    variables = { id: book.id, title: Faker::Book.title }
    result = GraphqlAppSchema.execute(
      update_book_query,
      variables: variables
    )['data']['updateBook']

    expect(Book.count).to eq(book_count)
    expect(result['book']['id']).to eq(book.id.to_s)
    expect(result['book']['title']).to eq(variables[:title])
    expect(result['errors']).to be_empty
  end

  it 'should fail to update book for duplicate title' do
    book1 = create(:book, user_id: user.id)
    book_count = Book.count
    variables = { id: book.id, title: book1.title }
    result = GraphqlAppSchema.execute(
      update_book_query,
      variables: variables
    )['data']['updateBook']

    expect(Book.count).to eq(book_count)
    expect(result['errors']).to eq(['Title has already been taken'])
  end
end
