FactoryBot.define do
  factory :book do
    association :author, factory: :author
    title { Faker::Book.title }
  end
end