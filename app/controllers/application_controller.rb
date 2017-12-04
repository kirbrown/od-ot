class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, prepend: true

  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  add_flash_types :success, :error

  helper_method :logged_in?
  helper_method :current_user

  private

  def go_back_link_to(path)
    @go_back_link_to ||= path
    @go_back_link_to
  end

  def render_404
    respond_to do |format|
      format.html do
        render file: 'public/404.html', status: :not_found, layout: false
      end
      format.json do
        render status: 404, json: {
          message: 'Not found.'
        }
      end
    end
  end

  def render_error
    render file: 'public/500.html', status: :internal_server_error, layout: false
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    elsif cookies.permanent.signed[:remember_me_token]
      verification
    end
  end

  def verification
    verification = Rails.application
                        .message_verifier(:remember_me)
                        .verify(cookies.permanent.signed[:remember_me_token])

    return unless verification

    Rails.logger.info 'Logging in by cookie.'
    @current_user ||= User.find(verification)
  end

  def require_user
    if current_user
      true
    else
      redirect_to sign_in_path, notice: 'You must be logged in to access that page.'
    end
  end

  def logged_in?
    current_user
  end

  def user_not_authorized
    redirect_back(fallback_location: (request.referer || root_path),
                  error: 'You are not authorized to perform this action.')
  end
end
