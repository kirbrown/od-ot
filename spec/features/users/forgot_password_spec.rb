require 'rails_helper'

describe 'Forgotten Passwords' do
  let!(:user) { create(:user) }

  it 'sends a user an email' do
    visit login_path
    click_link 'Forgot Password'
    fill_in 'Email', with: user.email
    expect {
      click_button 'Send Instructions'
    }.to change{ ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'resets a password when following the email link' do
    visit login_path
    click_link 'Forgot Password'
    fill_in 'Email', with: user.email
    click_button 'Send Instructions'
    open_email(user.email)
    current_email.click_link 'http://'
    expect(page).to have_content('Change Your Password')

    fill_in 'Password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'newpassword'
    click_button 'Change Password'
    expect(page).to have_content('Password updated.')
    expect(page.current_path).to eq(todo_lists_path)

    click_link 'Sign Out'
    expect(page).to have_content('You have been logged out.')
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'newpassword'
    click_button 'Sign In'
    expect(page).to have_content('Thanks for logging in!')
  end
end
