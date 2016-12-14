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

  it "target_priceが空欄ならNG" do
      item = Item.new(name: "アイテム名", target_price: "")
      expect(item).not_to be_valid
  end

  # limited_at(募集期間の終了日)、過去の日付は不可
  it "limited_atが今日の日付ならOK" do
    d = Date.today
    item = Item.new(
      name: "アイテム名",
      target_price: 100,
      "limited_at(1i)"=>d.year.to_s, "limited_at(2i)"=> d.month.to_s, "limited_at(3i)"=> d.day.to_s
    )
    expect(item).to be_valid
  end

  it "limited_atが過去の日付ならNG" do
    d = Date.today-1
    item = Item.new(
      name: "アイテム名",
      target_price: 100,
      "limited_at(1i)"=>d.year.to_s, "limited_at(2i)"=> d.month.to_s, "limited_at(3i)"=> d.day.to_s
    )
    expect(item).not_to be_valid
  end
end
