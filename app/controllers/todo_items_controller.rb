class TodoItemsController < ApplicationController
  before_action :require_user
  before_action :find_todo_list
  before_action :find_todo_item, only: %i[edit update destroy complete]
  before_action :set_back_link, except: %i[index]

  def index
    go_back_link_to todo_lists_path
  end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = 'Added todo list item.'
      redirect_to todo_list_todo_items_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = 'Saved todo list item.'
      redirect_to todo_list_todo_items_path
    else
      render :edit
    end
  end

  def destroy
    if @todo_item.destroy
      flash[:success] = 'Todo list item was deleted.'
    else
      flash[:error] = 'Todo list item could not be deleted.'
    end
    redirect_to todo_list_todo_items_path
  end

  def complete
    @todo_item.toggle_completion!
    redirect_to todo_list_todo_items_path, success: 'Todo item status updated.'
  end

  private

  def set_back_link
    go_back_link_to todo_list_todo_items_path(@todo_list)
  end

  def find_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def find_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
