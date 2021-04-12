class PasswordResetsController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver_now
      flash[:success] = 'Password reset instructions sent! Please check your email.'
      redirect_to sign_in_path
    else
      flash.now[:notice] = 'Email not found.'
      render 'new'
    end
  end

  def edit
    render file: 'public/404.html', status: :not_found, layout: false unless @user
  end

  def update
    if @user&.update(user_params).present?
      @user.update(password_reset_token: nil)
      session[:user_id] = @user.id
      redirect_to todo_lists_path, success: 'Password updated.'
    else
      flash.now[:notice] = 'Password reset token not found.'
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find_by(password_reset_token: params[:id])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
