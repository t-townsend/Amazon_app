FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    sequence(:email) { |n| "john#{n}@smith.com" }
    password '12345678'
  end
end
