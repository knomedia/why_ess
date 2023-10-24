class Api::V1::ApplicationController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :require_auth

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  private

  def handle_record_not_found
    render json: {message: 'forbidden'}, status: :forbidden
  end

  def require_auth
    render json: {error: 'unauthorized'}, status: :unauthorized unless current_account
  end

  def current_account
    @current_account ||= Auth::Helper.current_account(request, params[:token])
  end

end
