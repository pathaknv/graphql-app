# frozen_string_literal: true

class User < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :email, uniqueness: true
end
