FactoryBot.define do
  factory :playlist do
    sequence :name do |n|
      "#{n}name"
    end
    
    number_of_favorites { 1 }
    user
    
    factory :playlist_with_videos do
      transient do
        playlist_videos_count { 5 }
      end
      
      after(:create) do |playlist, evaluator|
        create_list(:playlist_video, evaluator.playlist_videos_count, playlist: playlist)
      end
    end
  end
end
