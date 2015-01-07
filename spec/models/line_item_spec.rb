require 'rails_helper'

RSpec.describe LineItem, :type => :model do
  
  before do
    @line_item = create(:line_item)
  end
  
  describe 'builder' do
    it 'is valid' do
      expect(@line_item).to be_valid 
    end
  end
  
  describe 'validations' do
    it 'user_id and item_id pair must be unique' do
      line_item2 = create(:line_item)
      line_item2.user = @line_item.user
      line_item2.item = @line_item.item
      
      expect(line_item2).not_to be_valid
    end
  end
  
  describe '#can_destroy' do
    it 'line_items user can destroy the line item' do
      expect(@line_item.can_destroy?(@line_item.user)).to be true
    end 
    
    it 'other user cannot destroy the line_item' do
      expect(@line_item.can_destroy?(build(:user))).to be false
    end
  end
end
