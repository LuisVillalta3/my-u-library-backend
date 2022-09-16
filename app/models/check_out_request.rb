class CheckOutRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :request_status
end
