class Role < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: true }, on: :create
  #
  has_many :users, dependent: :destroy
end
