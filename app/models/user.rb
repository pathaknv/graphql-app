class User < ApplicationRecord
  has_many :books

  validates :email, uniqueness: true
end
