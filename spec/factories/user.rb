FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email } 
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    latitude 40.652682
    longitude -73.960462
    password "jess"
    password_confirmation "jess"
    dob Date.today
  end
end