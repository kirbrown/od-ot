module ApplicationHelper

  def title(title)
    content_for(:title) { "#{title} | " }
    content_tag(:h2, title, class: 'page-title truncate', title: title)
  end

  def new_item_link
    if @todo_list && !@todo_list.new_record?
      path = new_todo_list_todo_item_path(@todo_list)
    else
      path = new_todo_list_path
    end

    link_to path do
      html = <<-HTML
        <span class='fa fa-plus float-right'></span>
      HTML
      html.html_safe
    end
  end

end
