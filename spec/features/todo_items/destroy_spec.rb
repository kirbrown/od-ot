require 'rails_helper'

describe 'Deleting todo items' do
  let(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list) }
  let!(:todo_item) { todo_list.todo_items.create(content: 'Milk') }
  before { sign_in todo_list.user, password: 'password1234' }

  it 'is successful' do
    pending 'Adding delete link'
    visit_todo_list(todo_list)
    within dom_id_for(todo_item) do
      click_link 'Delete'
    end
    expect(page).to have_content('Todo list item was deleted.')
    expect(TodoItem.count).to eq(0)
  end
end
