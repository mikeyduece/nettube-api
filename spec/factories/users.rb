FactoryBot.define do
  factory :user do
    first_name { 'FirstName' }
    last_name { 'LastName' }
    sequence :email do |n|
      "#{n}my_email@email.com"
    end
    
    password { 'password' }
  end
end
