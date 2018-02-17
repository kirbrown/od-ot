module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_tokens, raise: false
    protect_from_forgery with: :null_session, prepend: true
    before_action :authenticate

    # rubocop:disable Metrics/MethodLength
    def authenticate
      authenticate_or_request_with_http_basic do |email, password|
        Rails.logger.info "API authentication: #{email}, #{password}."
        user = User.find_by(email: email)
        if user&.authenticate(password)
          @current_user = user
          Rails.logger.info "Logging in #{user.inspect}."
          true
        else
          Rails.logger.warn 'No valid credentials!'
          false
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    private

    attr_reader :current_user
  end
end
