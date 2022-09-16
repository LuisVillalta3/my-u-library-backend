FactoryBot.define do
  factory :request_status do
    name { Faker::Name.first_name }
  end
end
