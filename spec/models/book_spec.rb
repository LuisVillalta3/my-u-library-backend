require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:author) { Author.create(firstName: "John", lastName: "Doe", birthday: '03-03-2000', nacionality: 'S') }
  let(:genre) { Genre.create(name: "John") }
  subject { Book.new(title: 'Titulo', author: author, genre: genre, published_date: '03-03-2000', in_stock: 1, available: true) }
  #
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
  it { should validate_presence_of(:author_id) }
  it { should validate_presence_of(:genre_id) }
  it { should validate_presence_of(:published_date) }
  it { should validate_presence_of(:in_stock) }
  it { should validate_numericality_of(:in_stock).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_inclusion_of(:available).in_array([true, false]) }
end
