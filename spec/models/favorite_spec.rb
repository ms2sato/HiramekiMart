require 'rails_helper'

describe Favorite do
  let(:user) { FactoryGirl.create(:user) }

  it "同じアイテムを複数回お気に入りにできない" do
    favorite = user.favorites.build(item_id: 100)
    expect(favorite.save).to be_truthy
    favorite = user.favorites.build(item_id: 100)
    expect(favorite.save).to be_falsey
  end
end
