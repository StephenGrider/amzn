class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def require_admin
    unless current_user.admin?
      redirect_to 'users/sign_in'
    end
  end
end
