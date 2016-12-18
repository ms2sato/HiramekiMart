require 'rails_helper'

describe Item do
  # name(アイテム名)、not null、20文字以内
  it "nameが存在すればOK" do
    item = Item.new(name: "アイテム名", target_price: 100)
    expect(item).to be_valid
  end

  it "nameが存在しなければNG" do
    item = Item.new(name: "", target_price: 100)
    expect(item).not_to be_valid
  end

  it "nameが20文字以上ならNG" do
    str = "a"*21
    item = Item.new(name: str, target_price: 100)
    expect(item).not_to be_valid
  end

  # target_price(目標金額)、not null、数字のみ

  it "target_priceが存在すればOK" do
    item = Item.new(name: "アイテム名", target_price: 100)
    expect(item).to be_valid
  end

  it "target_priceが存在しなければNG" do
      item = Item.new(name: "アイテム名", target_price: "")
      expect(item).not_to be_valid
  end

  it "target_priceがアルファベットならNG" do
      item = Item.new(name: "アイテム名", target_price: "A")
      expect(item).not_to be_valid
  end

  it "target_priceが記号ならNG" do
      item = Item.new(name: "アイテム名", target_price: "@")
      expect(item).not_to be_valid
  end

  it "target_priceがひらがなならNG" do
      item = Item.new(name: "アイテム名", target_price: "あ")
      expect(item).not_to be_valid
  end

  it "target_priceがゼロならNG" do
      item = Item.new(name: "アイテム名", target_price: 0)
      expect(item).not_to be_valid
  end

  # limited_at(募集期間の終了日)、過去の日付は不可
  it "limited_atが今日の日付ならOK" do
    d = Date.today
    item = Item.new(
      name: "アイテム名",
      target_price: 100,
      limited_at: d,
    )
    expect(item).to be_valid
  end

  it "limited_atが過去の日付ならNG" do
    d = Date.today-1
    item = Item.new(
      name: "アイテム名",
      target_price: 100,
      limited_at: d,
    )
    expect(item).not_to be_valid
  end
end

describe 'editable_by?' do
  # editable_by?(user)　＊＊Itemを作成したuserかどうか真偽値で返す＊＊
  it "userがitemの作成者なので、真" do
    item = Item.new(user_id: 123, name: "アイテム名", target_price: 100)
    user = User.new(
      id:123,
      name: "ユーザ名",
      email: "user@test.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(item.editable_by?(user)).to eq true
  end

  it "userがitemの作成者ではないので、偽" do
    item = Item.new(user_id: 12345, name: "アイテム名", target_price: 100)
    user = User.new(
      id:555,
      name: "ユーザ名",
      email: "user@test.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(item.editable_by?(user)).to eq false
  end
end
