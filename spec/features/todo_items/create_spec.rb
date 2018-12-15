require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Viewing todo items' do
  let(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list) }
  before { sign_in todo_list.user }

  it 'is successful with valid content' do
    visit_todo_list(todo_list)
    click_link 'Add Todo Item'
    fill_in 'Content', with: 'Milk'
    click_button 'Save'

    expect(page).to have_content('Added todo list item.')
    within '.todo-items' do
      expect(page).to have_content('Milk')
    end
  end

  it 'displays an error with no content' do
    visit_todo_list(todo_list)
    click_link 'Add Todo Item'
    fill_in 'Content', with: ''
    click_button 'Save'
    expect(page).to have_content(/can't be blank/i)
  end

  it 'displays an error with content less than 2 characters long' do
    visit_todo_list(todo_list)
    click_link 'Add Todo Item'
    fill_in 'Content', with: '1'
    click_button 'Save'
    expect(page).to have_content(/is too short/i)
  end
end
# rubocop:enable Metrics/BlockLength
