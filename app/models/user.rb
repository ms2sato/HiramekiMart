class User < ActiveRecord::Base
  #relation
  has_many :items, dependent: :destroy
  has_many :supports, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
