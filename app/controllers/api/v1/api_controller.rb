module Api
  module V1
    class ApiController < ApplicationController
      before_filter :authenticate_user!
      before_filter :validate_params
    end
  end
end
