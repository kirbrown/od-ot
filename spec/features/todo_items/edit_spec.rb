require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Editing todo items' do
  let(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list) }
  let!(:todo_item) { todo_list.todo_items.create(content: 'Milk') }
  before { sign_in todo_list.user }

  it 'is successful with valid content' do
    visit_todo_list(todo_list)
    within dom_id_for(todo_item) do
      click_link todo_item.content
    end
    fill_in 'Content', with: 'Lots of Milk'
    click_button 'Save'

    expect(page).to have_content('Saved todo list item.')
    todo_item.reload
    expect(todo_item.content).to eq('Lots of Milk')
  end

  it 'is unsuccessful with no content' do
    visit_todo_list(todo_list)
    within dom_id_for(todo_item) do
      click_link todo_item.content
    end
    fill_in 'Content', with: ''
    click_button 'Save'

    expect(page).to_not have_content('Saved todo list item.')
    expect(page).to have_content(/can't be blank/i)
    todo_item.reload
    expect(todo_item.content).to eq('Milk')
  end

  it 'is unsuccessful with not enough content' do
    visit_todo_list(todo_list)
    within dom_id_for(todo_item) do
      click_link todo_item.content
    end
    fill_in 'Content', with: '1'
    click_button 'Save'

    expect(page).to_not have_content('Saved todo list item.')
    expect(page).to have_content(/is too short/i)
    todo_item.reload
    expect(todo_item.content).to eq('Milk')
  end
end
# rubocop:enable Metrics/BlockLength
