FactoryBot.define do
  factory :comment do
    body { 'This is my commet.' }
    user
    article
  end
end
