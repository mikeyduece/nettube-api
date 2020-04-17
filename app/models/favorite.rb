class Favorite < ApplicationRecord
  belongs_to :user, inverse_of: :favorites
  belongs_to :target, polymorphic: true, inverse_of: :favorites
  
  validates :user, :target, presence: true
  validates :user_id, uniqueness: { scope: %i[target_id target_type] }
  
  after_create :increment_number_of_favorites
  before_destroy :decrement_number_of_favorites
  
  private
  
  def increment_number_of_favorites
    new_total = target.number_of_favorites + 1
    
    target.update(number_of_favorites: new_total)
  end
  
  def decrement_number_of_favorites
    new_total = target.number_of_favorites - 1
    
    target.update(number_of_favorites: new_total)
  end
  
end