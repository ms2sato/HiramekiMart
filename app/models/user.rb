class User < ActiveRecord::Base
  #relation
  has_many :items, dependent: :destroy
  has_many :supports, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_items, through: :favorites, source: :item
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
