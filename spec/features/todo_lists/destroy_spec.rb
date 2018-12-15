require 'rails_helper'

describe 'Deleting todo lists' do
  let(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list) }
  before { sign_in todo_list.user }

  it 'is successful when clicking the destroy link' do
    visit '/todo_lists'
    click_link todo_list.title

    click_link 'Delete'

    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end
