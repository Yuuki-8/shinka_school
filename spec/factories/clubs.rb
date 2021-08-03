FactoryBot.define do
  factory :club do
    sequence(:name) { |n| "サークル_#{n}"}
    sequence(:description) { |n| "サークル_#{n}の活動内容です"}
    image { "test_image.jpg" }
  end
end