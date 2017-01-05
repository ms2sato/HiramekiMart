class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def create
    @item.add_fav(current_user)
    redirect_to @item, notice: 'お気に入りに登録されました'
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    redirect_to @item, notice: 'お気に入りから削除されました'
  end

  private
    def set_item
      @item = Item.find(params[:item_id])
    end
end
