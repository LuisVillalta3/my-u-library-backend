class Genre < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: true }, on: :create
end
