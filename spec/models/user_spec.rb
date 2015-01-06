describe User do

  before do
    @user = create(:user)
  end
  
  describe 'builder' do
    it 'is valid' do
      expect(@user).to be_valid 
    end
  end

end
