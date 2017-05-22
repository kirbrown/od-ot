class RemoveDescriptionFromTodoLists < ActiveRecord::Migration[5.0]
  def change
    remove_column :todo_lists, :description, :text
  end
end
