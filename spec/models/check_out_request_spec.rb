require 'rails_helper'

RSpec.describe CheckOutRequest, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:book) }
  it { should belong_to(:request_status) }
end
