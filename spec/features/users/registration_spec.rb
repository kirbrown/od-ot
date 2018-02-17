require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Signing Up' do
  it 'allows a user to sign up for the site & creates the object in the database' do
    expect(User.count).to eq(0)
    visit '/'
    click_link 'Sign Up'
    expect(page).to have_content('Registration')

    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'password1234'
    fill_in 'Password Confirmation', with: 'password1234'
    click_button 'Sign Up'
    expect(User.count).to eq(1)
  end

  it 'displays a tutorial when the user signs up' do
    visit '/'
    click_link 'Sign Up'

    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'password1234'
    fill_in 'Password Confirmation', with: 'password1234'
    click_button 'Sign Up'

    expect(page).to have_content('Od-ot Tutorial')

    click_on 'Od-ot Tutorial'

    expect(page.all('li.todo-item').size).to eq(7)
  end
end
# rubocop:enable Metrics/BlockLength
