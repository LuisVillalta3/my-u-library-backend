FactoryBot.define do
  factory :author do
    firstName { Faker::Name.first_name  }
    lastName { Faker::Name.last_name }
    birthday { Faker::Date.between(from: 200.years.ago, to: 18.years.ago) }
    nacionality { Faker::Name.first_name }
  end
end