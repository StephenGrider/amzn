module Api
  module V1
    class ItemsController < Api::V1::ApiController
      def index
        render json: Item.all.to_json
      end
    end
  end
end
