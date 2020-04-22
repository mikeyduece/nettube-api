module Favoritable
  extend ActiveSupport::Concern
  
  included do
    has_many :favorites
    has_many :favorited_by_users, through: :favorites, source: :user
  end
  
  class_methods do
    def favoritable(*attributes)
      attributes = [attributes] unless attributes.is_a?(Array)
      
      attributes.each do |attribute|
        class_eval "has_many :favorite_#{attribute}, through: :favorites, source: :target, source_type: '#{attribute.to_s.classify}'"
      end
    end
  end
  
end