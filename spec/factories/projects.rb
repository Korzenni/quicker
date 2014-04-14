# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "Testowy projekt"
    admin_name ""
    admin_email "example@example.com"
    admin_uri "example-uri"
  end
end
