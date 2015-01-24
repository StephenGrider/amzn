module Api
  module V1
    class ApiController < ApplicationController
      before_filter :authenticate_user!
    end
  end
end