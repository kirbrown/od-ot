class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index; end

  def new
    @user = User.new
  end

  def edit
    authorize!(@user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.create_default_lists
      session[:user_id] = @user.id
      redirect_to todo_lists_path, success: 'Thanks for signing up!'
    else
      render :new
    end
  end

  def update
    authorize!(@user)
    if @user.update(user_params)
      redirect_to root_path, success: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize!(@user)
    logging_out
    @user.destroy
    redirect_to root_path, success: 'User was successfully deleted.'
  end

  private

  def logging_out
    session[:user_id] = nil
    cookies.delete(:remember_me_token)
    reset_session
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
