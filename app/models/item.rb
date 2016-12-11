class Item < ActiveRecord::Base
  #Imgge_uploader
  mount_uploader :image, ImageUploader
end
