require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { Role.new(name: 'Student') }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
