FactoryBot.define do
  factory :comment do
    body { 'This is my comment.' }
    user
    article
  end
end
