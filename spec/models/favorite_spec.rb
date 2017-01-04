require 'rails_helper'

describe Favorite do
  let(:favorite) { FactoryGirl.create(:favorite) }
  let(:other) { FactoryGirl.build(:favorite) }

  # 同じアイテムを複数回お気に入りにできない
  it "user_idとitem_idの組み合わせがユニークなのでvalid" do
    expect(other).to be_valid
  end

  it "user_idとitem_idの組み合わせがユニークではないのでinvalid" do
    overlap = Favorite.new(user_id: favorite.user_id, item_id: favorite.item_id)
    expect(overlap).not_to be_valid
  end
end
