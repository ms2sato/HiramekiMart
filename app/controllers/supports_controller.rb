class SupportsController < ApplicationController
  before_filter :authenticate_user!
  def buy
    item = Item.find(params[:item_id])
    support = current_user.supports.build(item_id: item.id)
    support.save!
    redirect_to item_path(item.id)
  end
end
