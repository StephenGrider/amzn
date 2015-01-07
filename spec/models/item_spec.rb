require 'rails_helper'

RSpec.describe Item, :type => :model do
  
  before do
    @item = create(:item)
  end
  
  describe 'builder' do
    it 'is valid' do
      expect(@item).to be_valid 
    end
  end
  
  describe '#is_liked?' do
    it 'returns true if a given user likes' do
      user = create(:user)
      create(:line_item, user_id: user.id, item_id: @item.id)
      
      expect(@item.is_liked?(user)).to be true
    end
    
    it 'returns false if a given user does not like' do 
      user = create(:user)
      
      expect(@item.is_liked?(user)).to be false
    end
  end
end
