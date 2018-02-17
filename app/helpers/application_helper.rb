module ApplicationHelper
  def title(title)
    content_for(:title) { "#{title} | " }
    content_tag(:h2, title, class: 'page-title truncate', title: title)
  end

  def new_item_link
    if @todo_list&.persisted?
      text = 'Todo Item'
      path = new_todo_list_todo_item_path(@todo_list)
    else
      text = 'Todo List'
      path = new_todo_list_path
    end

    link_to path, title: "Add #{text}" do
      content_tag(:span, '', class: 'fa fa-plus float-right')
    end
  end
end
