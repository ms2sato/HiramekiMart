class Favorite < ActiveRecord::Base
  #relation
  belongs_to :user
  belongs_to :item
  #validation
  validates :user_id, uniqueness: { scope: [:item_id] }
end
