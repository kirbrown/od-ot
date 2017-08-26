require 'rails_helper'

describe 'Logging Out' do
  it 'allows a signed in user to sign out' do
    user = create(:user)
    visit '/todo_lists'
    expect(page).to have_content('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password1234'
    click_button 'Sign In'

    expect(page).to have_css('.fa-sign-out')
    page.find('.sign_out').click
    expect(page).to_not have_css('.fa-sign-out')
    expect(page).to have_content('Sign Up')
  end
end
