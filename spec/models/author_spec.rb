require 'rails_helper'

RSpec.describe Author, type: :model do
  # Validation Tests
  it { should validate_presence_of(:firstName) }
  it { should validate_presence_of(:lastName) }
  it { should validate_presence_of(:birthday) }
  it { should validate_presence_of(:nacionality) }
end
