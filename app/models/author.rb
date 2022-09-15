class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  # VALIDATIONS
  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :nacionality, presence: true
  validates :birthday, presence: true
end
