# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    start_time { "2021/8/1 10:00" }
    end_time { "2021/8/1 12:00" }
    working_time { 2.0 }
    association :admin
  end
end
