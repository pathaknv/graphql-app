class Book < ApplicationRecord
  belongs_to :user

  validates :title, uniqueness: true

  def user_name
    user.name
  end
end
