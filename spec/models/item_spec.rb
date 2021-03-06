require 'rails_helper'

describe Item do
  let(:item) { FactoryGirl.build(:item) }

  # 以下の４つの属性に対して値をセットしてvaildとなるか確認する
  it "user_id, name, target_price, limited_at, category, retail_price, statusが存在すればOK" do
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

  it "target_priceが全角数字なら半角に変換される" do
    item.target_price = "１２３４５"
    expect(item.target_price).to eq 12345
  end

  # limited_at(募集期間の終了日)、過去の日付は不可
  it "limited_atが過去の日付ならNG" do
    item.limited_at = Date.today-1
    expect(item).not_to be_valid
  end

  it "categoryが存在しなければNG" do
    item.category = nil
    expect(item).not_to be_valid
  end

  it "support_courseが存在しなければNG" do
    item.support_course = nil
    expect(item).not_to be_valid
  end

  it "support_courseがひらがなならNG" do
    item.support_course = "あ"
    expect(item).not_to be_valid
  end

  it "support_courseがゼロならNG" do
    item.support_course = 0
    expect(item).not_to be_valid
  end

  it "statusが存在しなければNG" do
    item.status = nil
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

  it "同じアイテムを複数回お気に入りにできない" do
    expect(item.add_fav(other).item_id).to eq item.id
    expect{ item.add_fav(other) }.to raise_error(ActiveRecord::RecordInvalid)
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

describe 'owner?' do
  let(:item) { FactoryGirl.create(:item) }
  let(:other) { FactoryGirl.create(:user) }

  # itemのownerかどうか真偽値で返す＊＊
  it "userがitemのownerなので、真" do
    expect(item.owner?(item.user)).to eq true
  end

  it "userがitemのownerではないので、偽" do
    expect(item.owner?(other)).to eq false
  end
end

describe 'succeeded?' do
  let(:item) { FactoryGirl.create(:item, target_price: 100, support_course: 100) }

  it "target_price以上の資金を集めているので、真" do
    item.supports.create(user_id: item.user.id)
    expect(item.succeeded?).to eq true
  end

  it "target_price以上の資金を集めていないので、偽" do
    expect(item.succeeded?).to eq false
  end
end

describe 'scope' do
  let(:items) {
    [
      FactoryGirl.create(:item, target_price: 9999, category: :toy_game),
      FactoryGirl.create(:item, target_price: 10000, category: :outdoors_sports),
      FactoryGirl.create(:item, target_price: 19999, category: :workspace),
      FactoryGirl.create(:item, target_price: 20000, category: :life_style),
      FactoryGirl.create(:item, target_price: 30000, category: :other)
    ]
  }

  describe 'low' do
    it "スコープ「low」で「target_price <= 9,999」のデータを検索できる" do
      expect(Item.price_range("low")).to include(items[0])
    end
  end

  describe 'middle' do
    it "スコープ「middle」で「10,000 <= target_price <= 19,999」のデータを検索できる" do
      expect(Item.price_range("middle")).to include(items[1],items[2])
    end
  end

  describe 'high' do
    it "スコープ「high」で「target_price >= 20,000」のデータを検索できる" do
      expect(Item.price_range("high")).to include(items[3])
    end
  end

  describe 'toy_game' do
    it "categoryが「toy_game」のアイテムを検索できる" do
      expect(Item.category("toy_game")).to include(items[0])
    end
  end

  describe 'outdoors_sports' do
    it "categoryが「outdoors_sports」のアイテムを検索できる" do
      expect(Item.category("outdoors_sports")).to include(items[1])
    end
  end

  describe 'workspace' do
    it "categoryが「workspace」のアイテムを検索できる" do
      expect(Item.category("workspace")).to include(items[2])
    end
  end

  describe 'life_style' do
    it "categoryが「life_style」のアイテムを検索できる" do
      expect(Item.category("life_style")).to include(items[3])
    end
  end

  describe 'other' do
    it "categoryが「other」のアイテムを検索できる" do
      expect(Item.category("other")).to include(items[4])
    end
  end
end

describe 'scope' do

  let!(:item) { FactoryGirl.create(:item, limited_at: Date.today) }

  describe 'over_limited' do
    it "募集期間を過ぎているアイテムを検索できる" do
      Timecop.travel(1.day.from_now) do
        expect(Item.over_limited).to include item
      end

      Timecop.travel(1.day.ago) do
        expect(Item.over_limited).not_to include item
      end

      expect(Item.over_limited).not_to include item
    end
  end

  describe 'under_limited' do
    it "募集期間中を過ぎていないアイテムを検索できる" do
      Timecop.travel(1.day.from_now) do
        expect(Item.under_limited).not_to include item
      end

      Timecop.travel(1.day.ago) do
        expect(Item.under_limited).to include item
      end

      expect(Item.under_limited).to include item
    end
  end
end
