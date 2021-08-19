# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    sequence(:title) { |n| "イベント_#{n}" }
    start_date { Date.today.since(8.days) }
    end_date { start_date.since(2.hours) }
    reservation_status { 0 }

    association :user
    association :mentor
  end
end
