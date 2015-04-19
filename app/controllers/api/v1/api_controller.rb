module Api
  module V1
    class ApiController < ApplicationController
      before_filter :authenticate_user!
      before_filter :validate_params

      def render_json(model, success)
        if success
          render json: model
        else
          render json: { errors: model.errors }, status: 422
        end
      end
    end
  end
end
