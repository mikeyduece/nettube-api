FactoryBot.define do
  factory :favorite do
    user
    association :target, factory: :video
  end
end
