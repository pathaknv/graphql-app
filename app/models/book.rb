# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user

  validates :title, uniqueness: true
end
