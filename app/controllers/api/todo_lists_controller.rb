class Api::TodoListsController < ApplicationController
  before_action :find_todo_list, only: [:show, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    render json: TodoList.all
  end

  def show
    render json: @list
  end

  def create
    list = TodoList.new(list_params)
    if list.save
      render json: {
        status: 200,
        message: 'Successfully created To-do List.',
        todo_list: list
      }.to_json
    else
      render json: {
        status: 500,
        message: list.errors,
        todo_list: list
      }.to_json
    end
  end

  def destroy
    @list.destroy
    render json: {
      status: 200,
      messsage: 'Successfully daleted To-do List.'
    }.to_json
  end

  private

  def list_params
    params.require(:todo_list).permit(:title)
  end

  def find_todo_list
    @list = TodoList.find(params[:id])
  end

end
