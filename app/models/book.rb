class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  # 
  has_many :check_out_requests, dependent: :destroy
  # 
  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: true }, on: :create
  validates :author_id, presence: true
  validates :genre_id, presence: true
  validates :published_date, presence: true
  validates :in_stock, presence: true
  validates :in_stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available, inclusion: { in: [true, false] }
end
