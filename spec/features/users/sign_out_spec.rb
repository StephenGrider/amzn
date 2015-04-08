feature 'Sign out', :devise do
  scenario 'user signs out successfully' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)

    expect(page).to have_content 'Sign out'
    click_link 'Sign out'
    expect(page).to have_content 'Sign in'
  end
end
