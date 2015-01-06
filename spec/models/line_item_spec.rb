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
end
