require 'spec_helper'

describe LineItemsController, :type => :controller do 
  before do
    @line_item = create(:line_item)
    @user = create(:user)
    sign_in @user
  end
  
  describe '#index' do
    it 'returns line_items' do
      get :index
      expect(assigns(:line_items)).to eq([@line_item])
    end
    
    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end
  end 
end