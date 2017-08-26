class TodoListsController < ApplicationController
  before_action :require_user
  before_action :set_todo_list, only: %i[edit update destroy email]
  before_action :set_back_link, except: %i[index show]

  def index
    @todo_lists = current_user.todo_lists
  end

  def show; end

  def new
    @todo_list = current_user.todo_lists.new
  end

  def edit; end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)

    if @todo_list.save
      redirect_to todo_list_todo_items_path(@todo_list), success: 'Todo list was successfully created.'
    else
      render :new, error: 'Todo list could not be created.'
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_list_todo_items_path(@todo_list), success: 'Todo list was successfully updated.'
    else
      render :edit, error: 'Todo list could not be updated.'
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_url, success: 'Todo list was successfully deleted.'
  end

  def email
    destination = params[:destination]
    notifier = Notifier.todo_list(@todo_list, destination)
    if destination =~ /@/ && notifier.deliver_now
      redirect_to todo_list_todo_items_path(@todo_list), success: 'Todo list send.'
    else
      redirect_to todo_list_todo_items_path(@todo_list), error: 'Todo list could not be sent.'
    end
  end

  private

  def set_back_link
    go_back_link_to todo_lists_path
  end

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
