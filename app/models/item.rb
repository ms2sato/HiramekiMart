class Item < ActiveRecord::Base
  #relation
  belongs_to :user
  has_many :supports, dependent: :destroy
  has_many :favorites, dependent: :destroy
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

  #check if you can edit
  def editable_by?(user)
    self.user_id == user.id
  end

  #add a item to your favorites
  def add_fav(user)
    raise StandardError, "このアイテムのオーナー様は、アイテムをお気に入り登録できません" if self.user_id == user.id
    user.favorites.create!(item_id: self.id)
  end

  #Find user's favorites
  def find_fav(user)
    @favorite = user.favorites.find_by(item_id: self.id)
  end

  #Is it a user's favorite?
  def favorited_by?(user)
    self.find_fav(user).present?
  end
end
