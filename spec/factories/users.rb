# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Example name"
    email "Example email"
    uri "my-uri"
    project_id 1
  end
end
