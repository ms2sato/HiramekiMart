class Favorite < ActiveRecord::Base
  #relation
  belongs_to :user
  belongs_to :item
  
  #validation
  validates :user_id, uniqueness: { scope: [:item_id] }

  #check if you can addfav
  def favorited_by?(user)
    self.user_id == user.id
  end
end
