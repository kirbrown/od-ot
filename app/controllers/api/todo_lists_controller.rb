module Api
  class TodoListsController < Api::BaseController
    before_action :find_todo_list, only: %i[show update destroy]

    def index
      Rails.logger.info "Current user: #{current_user.inspect}"
      render json: TodoList.all
    end

    def show
      render json: @list.as_json(include: [:todo_items])
    end

    # rubocop:disable Metrics/MethodLength
    def create
      list = current_user.todo_lists.new(list_params)
      if list.save
        render status: :ok, json: {
          message: 'Successfully created To-do List.',
          todo_list: list
        }.to_json
      else
        render status: :unprocessable_entity, json: {
          message: list.errors,
          todo_list: list
        }.to_json
      end
    end

    def update
      if @list.update(list_params)
        render status: :ok, json: {
          message: 'Successfully updated.',
          todo_list: @list
        }.to_json
      else
        render status: :unprocessable_entity, json: {
          message: 'The To-do list could not be updated.',
          todo_list: @list
        }.to_json
      end
    end
    # rubocop:enable Metrics/MethodLength

    def destroy
      @list.destroy
      render status: :ok, json: {
        messsage: 'Successfully deleted To-do List.'
      }.to_json
    end

    private

    def list_params
      params.require(:todo_list).permit(:title)
    end

    def find_todo_list
      @list = current_user.todo_lists.find(params[:id])
    end
  end
end
