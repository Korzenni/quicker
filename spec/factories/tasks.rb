# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    start_date "2014-05-06"
    end_date "2014-05-08"
    sequence(:name)  { |n| "Task #{n}" }
    user
    project
  end
end
