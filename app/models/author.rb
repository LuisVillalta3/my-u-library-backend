class Author < ApplicationRecord
  # VALIDATIONS
  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :nacionality, presence: true
  validates :birthday, presence: true
end
