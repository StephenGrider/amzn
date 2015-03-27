class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
  before_action :parse_params

  def require_admin
    unless current_user.admin?
      redirect_to 'users/sign_in'
    end
  end

  def parse_params
    params.each do |k, v|
      params[k] = true if v == 'true'
      params[k] = false if v == 'false'
    end
  end
end
