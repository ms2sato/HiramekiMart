require 'rails_helper'

describe Item do
  let(:item){ FactoryGirl.build(:item)}

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
