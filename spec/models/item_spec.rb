require 'rails_helper'

describe Item do
  let(:item) { FactoryGirl.build(:item) }

  # 以下の４つの属性に対して値をセットしてvaildとなるか確認する
  it "user_id, name, target_price, limited_atが存在すればOK" do
    expect(item).to be_valid
  end

  # name(アイテム名)、not null、20文字以内
  it "nameが存在しなければNG" do
    item.name = nil
    expect(item).not_to be_valid
  end

  it "nameが20文字以上ならNG" do
    item.name = "a"*21
    expect(item).not_to be_valid
  end

  # target_price(目標金額)、not null、数字のみ

  it "target_priceが存在しなければNG" do
      item.target_price = nil
      expect(item).not_to be_valid
  end

  it "target_priceがアルファベットならNG" do
      item.target_price = "A"
      expect(item).not_to be_valid
  end

  it "target_priceが記号ならNG" do
    item.target_price = "@"
      expect(item).not_to be_valid
  end

  it "target_priceがひらがなならNG" do
    item.target_price = "あ"
      expect(item).not_to be_valid
  end

  it "target_priceがゼロならNG" do
    item.target_price = 0
      expect(item).not_to be_valid
  end

  # limited_at(募集期間の終了日)、過去の日付は不可
  it "limited_atが過去の日付ならNG" do
    item.limited_at = Date.today-1
    expect(item).not_to be_valid
  end
end

describe 'editable_by?' do
  let(:item) { FactoryGirl.create(:item) }
  let(:other) { FactoryGirl.create(:user) }

  # editable_by?(user)　＊＊itemを作成したuserかどうか真偽値で返す＊＊
  it "userがitemの作成者なので、真" do
    expect(item.editable_by?(item.user)).to eq true
  end

  it "userがitemの作成者ではないので、偽" do
    expect(item.editable_by?(other)).to eq false
  end
end

describe 'add_fav' do
  let(:item) { FactoryGirl.create(:item) }
  let(:other) { FactoryGirl.create(:user) }

  # user_idとitem_idが異なればお気に入りが一件作成される
  it "user_idに有効な情報が保持されている" do
    expect(item.add_fav(other).item_id).to eq item.id
  end

  it "item_idに有効な情報が保持されている" do
    expect(item.add_fav(other).user_id).to eq other.id
  end

  it "favoritesテーブルに一件レコードが追加されている" do
    expect{ item.add_fav(other) }.to change(Favorite, :count).by(1)
  end

  # user_idとitem_idが同一ならStanderdErrorを投げる
  it "自分がオーナーのアイテムはお気に入りに追加できない" do
    expect{ item.add_fav(item.user) }.to raise_error(StandardError)
  end
end

describe 'find_fav' do
  let(:item) { FactoryGirl.create(:item) }
  let(:other) { FactoryGirl.create(:user) }

  # userのお気に入りのデータを返す
  it "favoriteが存在すれば有効な値が返される" do
    favorite = other.favorites.create(item_id: item.id)
    expect(item.find_fav(other).id).to eq favorite.id
  end

  it "favoriteが存在しなければnilが返される" do
    expect(item.find_fav(other)).to eq nil
  end
end

describe 'favorited_by?' do
  let(:item) { FactoryGirl.create(:item) }
  let(:other) { FactoryGirl.create(:user) }

  #userがitemをお気に入りしているかどうか真偽値で返す
  it "itemがお気に入りされているので、真" do
    favorite = other.favorites.create(item_id: item.id)
    expect(item.favorited_by?(other)).to eq true
  end

  it "itemがお気に入りされていないので、偽" do
    expect(item.favorited_by?(other)).to eq false
  end
end
