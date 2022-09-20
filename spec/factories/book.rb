FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { create(:author) }
    genre { create(:genre) }
    published_date { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    in_stock { Faker::Number.between(from: 0, to: 100) }
    available { Faker::Boolean.boolean }
  end
end
