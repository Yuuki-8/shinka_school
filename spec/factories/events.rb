# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "イベント_#{n}" }
    sequence(:place) { |n| "イベント場所_#{n}" }
    start_date { "2021/8/1 10:00" }
    end_date { "2021/8/1 12:00" }
    deadline_date { "2021/7/31 17:00" }
  end
end
