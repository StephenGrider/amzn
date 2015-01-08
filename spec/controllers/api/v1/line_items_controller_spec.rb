require 'spec_helper'

describe Api::V1::LineItemsController, :type => :controller do 
  
  describe '#index' do
    
  end
  
  describe '#create' do
    context 'valid attributes' do
      it 'creates a new line_item' do
        expect{
          post :create, line_item: FactoryGirl.attributes_for(:line_item)
        }.to change(LineItem, :count).by(1)
      end
      
      it 'returns the new model' do
        expect(response).to be_blank
      end
    end
      
      context 'invalid attributes' do
        it 'does not create a new line_item' do
          
        end
        
        it 'renders nothing' do
          
        end
      end
  end
  
  describe '#destroy' do
    it 'deletes' do
      
    end
    
    it 'renders nothing' do
      
    end
  end
end
