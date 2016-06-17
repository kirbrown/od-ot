require 'rails_helper'

describe 'Deleting todo lists' do
  let(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list) }
  before { sign_in todo_list.user, password: 'password1234' }

  it 'is successful when clicking the destroy link' do
    pending 'Deleting todo lists'
    visit '/todo_lists'

    within dom_id_for(todo_list) do
      click_link 'Delete'
    end

    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end
