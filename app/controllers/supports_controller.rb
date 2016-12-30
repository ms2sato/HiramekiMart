class SupportsController < ApplicationController
  before_action :set_item
  before_action :store_event_url
  before_action :authenticate_user!

  def buy
    current_user.supports.create!(item_id: @item.id)
    redirect_to item_path(@item.id)
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:item_id])
  end

  def store_event_url
    session[:user_return_to] = item_path(@item) unless user_signed_in?
  end
end
