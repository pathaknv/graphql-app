# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Books::DeleteBook do
  let!(:user) { create(:user) }
  let!(:book) { create(:book, user_id: user.id) }
  let(:delete_book_query) do
    <<~GraphQL
      mutation deleteBook($id: ID!) {
        deleteBook(input: { id: $id }) {
          message
        }
      }
    GraphQL
  end

  it 'should delete book' do
    book_count = Book.count
    result = GraphqlAppSchema.execute(
      delete_book_query,
      variables: { id: book.id }
    )['data']['deleteBook']

    expect(Book.count).to eq(book_count - 1)
    expect(result['message']).to eq('Book deleted!')
  end
end
