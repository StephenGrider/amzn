require 'rails_helper'

RSpec.describe Item, :type => :model do

  before do
    @user = create(:user)

    @disliked_item = create(:item)
    LineItem.create(item_id: @disliked_item.id, user_id: @user.id, liked: false)

    @liked_item = create(:item)
    LineItem.create(item_id: @liked_item.id, user_id: @user.id, liked: true)

    @unrated_item = create(:item)
  end

  describe 'builder' do
    it 'is valid' do
      expect(@disliked_item).to be_valid
      expect(@liked_item).to be_valid
      expect(@unrated_item).to be_valid
    end
  end

  describe 'scopes' do
    describe 'unrated_by' do
      it 'returns items that the provided user has not rated' do
        items = Item.unrated_by(@user)
        expect(items).to eq([@unrated_item])
      end
    end

    describe 'liked_by' do
      it 'returns items that the provided user has liked' do
        items = Item.liked_by(@user)
        expect(items).to eq([@liked_item])
      end
    end

    describe 'disliked_by' do
      it 'returns items that the provided user has liked' do
        items = Item.disliked_by(@user)
        expect(items).to eq([@disliked_item])
      end
    end
  end

  describe '#is_liked?' do
    it 'returns true if a given user likes' do
      expect(@liked_item.is_liked?(@user)).to be true
    end

    it 'returns false if a given user does not like or is unrated' do
      expect(@disliked_item.is_liked?(@user)).to be false
      expect(@unrated_item.is_liked?(@user)).to be false
    end
  end
end
