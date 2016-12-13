class Item < ActiveRecord::Base
  #relation
  belongs_to :user
  has_many :supports, dependent: :destroy
  #Imgge_uploader
  mount_uploader :image, ImageUploader
  #validation
  validates :name, presence: true, length: { maximum: 20 }
  validates :target_price, presence: true, numericality: {
            only_integer: true, greater_than: 0
          }
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if limited_at.present? && limited_at < Date.today
      errors.add(:limited_at, "には過去の日付は使用できません")
    end
  end
end
