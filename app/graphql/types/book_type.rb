module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :user_id, ID, null: false
    field :user_name, String, null: false
  end
end
