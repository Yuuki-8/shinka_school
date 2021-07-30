FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:name_kana) { |n| "テストネーム#{n}"}
    sequence(:nickname) { |n| "ニックネーム#{n}"}
    phone { "09011111111" }
    birthday { "2000/1/1" }
    gender { 0 }
    work_place { "鹿児島" }
    self_introduction { "よろしくお願いします" }
    password { "testpass" }
    password_confirmation { "testpass" }
    sequence(:email) { |n| "TEST#{n}@example.com"}

    association :job
    association :pref
  end
end