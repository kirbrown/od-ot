require 'rails_helper'

describe 'Logging In' do
  it 'logs the user in and goes to the todo lists' do
    User.create(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'john@doe.com',
        :password => 'password1234',
        :password_confirmation => 'password1234'
    )
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'password1234'
    click_button 'Log In'
    
    expect(page).to have_content('Todo Lists')
    expect(page).to have_content('Thanks for logging in!')
  end

  it 'diplays the email address in the event of a failed login' do
    visit new_user_session_path
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'incorrect'
    click_button 'Log In'

    expect(page).to have_content('Please check your email and password')
    expect(page).to have_field('Email', with: 'john@doe.com')
  end
end
