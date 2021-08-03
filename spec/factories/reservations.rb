FactoryBot.define do
  factory :reservation do
    sequence(:title) { |n| "イベント_#{n}"}
    start_date { "2021/8/1 10:00" }
    end_date { "2021/8/1 12:00" }
    reservation_status { 0 }

    association :user
    association :mentor
  end
end