require 'rails_helper'

describe TodoList do
  context 'relationships' do
    it { should have_many(:todo_items) }
    it { should belong_to(:user) }
  end
end
