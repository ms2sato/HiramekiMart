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
  validates :category, presence: true

  #scope
  scope :low, -> { where target_price: 1..9999 }                  # 1 〜 19,999円
  scope :middle, -> { where target_price: 10000..19999 }          #10,000 〜 19,999円
  scope :high, -> { where target_price: 20000..Float::INFINITY }  #20,000円以上

  scope :price_range, ->(price) {
      return low if price == 'low'
      return middle if price == 'middle'
      return high if price == 'high'
      all # 条件に合わなければall
  }

  #check if you can edit
  def editable_by?(user)
    self.user_id == user.id
  end

  #check if the owner of the item
  def owner?(user)
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

  # enum
  enum category: { toy_game: 0, outdoors_sports: 1, workspace: 2, life_style: 3, other: 4 }

  #Convert ZENKAKU to HANKAKU characters
  def target_price=(value)
    value.tr!('０-９', '0-9') if value.is_a?(String)
    super(value)
  end
end
