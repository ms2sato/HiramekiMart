# favorite(お気に入り)が他人のものでないかどうかたしかめる
describe 'favorited_by?' do
  let(:favorite) { FactoryGirl.create(:favorite) }
  let(:other) { FactoryGirl.create(:user) }

  it "current_userのfavoriteなので、真" do
    expect(favorite.favorited_by?(favorite.user)).to eq true
  end

  it "current_userのfavoriteではないので、偽" do
    expect(favorite.favorited_by?(other)).to eq false
  end
end
