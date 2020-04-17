FactoryBot.define do
  factory :playlist do
    sequence :name do |n|
      "#{n}name"
    end
    
    number_of_favorites { 1 }
    user
    video
  end
end
