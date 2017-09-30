module ApplicationHelper
  def title(title)
    content_for(:title) { "#{title} | " }
    content_tag(:h2, title, class: 'page-title truncate', title: title)
  end

  # rubocop:disable Style/SafeNavigation
  def new_item_link
    if @todo_list && !@todo_list.new_record?
      text, path = 'Todo Item', new_todo_list_todo_item_path(@todo_list)
    else
      text, path = 'Todo List', new_todo_list_path
    end

    link_to path, title: "Add #{text}" do
      html = <<-HTML
        <span class='fa fa-plus float-right'></span>
      HTML
      html.html_safe
    end
  end
  # rubocop:enable Style/SafeNavigation
end
