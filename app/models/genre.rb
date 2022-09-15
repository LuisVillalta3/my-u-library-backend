class Genre < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: true }, on: :create
end
