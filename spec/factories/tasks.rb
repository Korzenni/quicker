# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    start_date "2014-04-06"
    end_date "2014-04-08"
    name "Example task"
    user_id 1
    project_id 1
  end
end
