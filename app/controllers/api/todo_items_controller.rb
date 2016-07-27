class Api::TodoItemsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :find_todo_list
  before_action :find_todo_item, only: [:update, :destroy]

  def create
    item = @list.todo_items.new(item_params)
    if item.save
      render status: 200, json: {
          message: 'Successfully created To-do Item.',
          todo_list: @list,
          todo_item: item
      }.to_json
    else
      render status: 422, json: {
          message: 'To-do Item creation failed.',
          errors: item.errors
      }.to_json
    end
  end

  def update
    if @item.update(item_params)
      render status: 200, json: {
          message: 'Successfully updated To-do Item.',
          todo_list: @list,
          todo_item: @item
      }.to_json
    else
      render status: 422, json: {
          message: 'To-do Item update is failed.',
          errors: @item.errors
      }.to_json
    end
  end

  def destroy
    @item.destroy
    render status: 200, json: {
        messsage: 'Successfully deleted To-do Item.'
    }.to_json
  end

  private

  def item_params
    params.require(:todo_item).permit(:content)
  end

  def find_todo_list
    @list = TodoList.find(params[:todo_list_id])
  end

  def find_todo_item
    @item = @list.todo_items.find(params[:id])
  end

end