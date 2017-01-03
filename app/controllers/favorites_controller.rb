class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_make_favorite

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

    # Check if the owner of the item.
    def check_make_favorite
      raise PermissionDeniedError, "このアイテムはお気に入りにできません" if @item.editable_by?(current_user)
    end
end
