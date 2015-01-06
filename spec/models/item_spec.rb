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
end
