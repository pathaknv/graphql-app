# frozen_string_literal: true

module Types
  # User Type
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :books, [Types::BookType], null: true do
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end
    field :books_count, Integer, null: true
    field :first_book, Types::BookType, null: true

    def books(limit: nil, offset: nil)
      if limit.present? || offset.present?
        object.books.offset(offset).limit(limit)
      else
        lazy_load_books(object.id)
      end
    end

    def books_count
      object.books.count
    end

    def first_book
      object.books.first
    end

    private

    def lazy_load_books(user_id)
      BatchLoader::GraphQL.for(user_id).batch(default_value: []) do |user_ids, loader|
        Book.where(user_id: user_ids).each do |book|
          loader.call(book.user_id) { |data| data << book }
        end
      end
    end
  end
end
