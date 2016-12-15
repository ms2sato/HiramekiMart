class Item < ActiveRecord::Base
  #relation
  belongs_to :user
  has_many :supports
  #Imgge_uploader
  mount_uploader :image, ImageUploader
  #validation
  validates :name, presence: true
  validates :target_price, presence: true, numericality: {
            only_integer: true, greater_than: 0
          }

  #check if you can edit
  def editable_by?(user)
    self.user_id == user.id
  end
end
