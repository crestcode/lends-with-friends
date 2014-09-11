# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friend do
    first_name 'Test'
    last_name 'Test'
    email 'test@test.com'
    phone '555-555-5555'
  end
end
