FactoryGirl.define do
  factory :location do
    name {Faker::Lorem.words(2).join(" ")}
    zip_code {Faker::AddressUS.zip_code}
   end
 end