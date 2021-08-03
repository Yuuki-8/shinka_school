FactoryBot.define do
  factory :admin do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    password { "testpass" }
    password_confirmation { "testpass" }
    sequence(:email) { |n| "TEST#{n}@example.com"}
  end
end