class Item < ActiveRecord::Base
  #relation
  belongs_to :user
  #Imgge_uploader
  mount_uploader :image, ImageUploader
  #validation
  validates :name, presence: true
  validates :target_price, presence: true, numericality: {
            only_integer: true, greater_than: 0
          }
end
