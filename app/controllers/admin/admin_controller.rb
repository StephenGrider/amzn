module Admin
  class AdminController < ApplicationController
    before_filter :require_admin

    def index
    end

    def fetch
      render :nothing => true, :status => 200
    end
  end
end
