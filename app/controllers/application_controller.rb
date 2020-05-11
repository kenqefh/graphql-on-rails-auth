# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :authenticate_user

  def authenticate_user
    return if @current_user

    set_headers_for_development

    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        raise ActionPolicy::Unauthorized
      end
    end
  end

  def current_user
    @current_user ||= User.find(@current_user_id) if @current_user_id
  end

  def signed_in?
    @current_user_id.present?
  end

  def authenticate_user!
    head :unauthorized unless signed_in?
  end

  private

  def set_headers_for_development
    if Rails.env.development? && ENV['JWT_TOKEN'].present?
      request.headers['Authorization'] = "Token #{ENV['JWT_TOKEN']}"
    end
  end
end
