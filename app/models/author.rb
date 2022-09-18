class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  # VALIDATIONS
  validates :first_name, presence: true
  validates :last_ame, presence: true
  validates :nacionality, presence: true
  validates :birthday, presence: true
end
