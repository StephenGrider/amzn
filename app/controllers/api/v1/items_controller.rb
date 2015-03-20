module Api
  module V1
    class ItemsController < Api::V1::ApiController
      def index
        items = Item.where(nil)
        items = items.liked_by(current_user) if item_params[:liked]
        items = items.unrated_by(current_user) if item_params[:unrated]

        render json: json.paginate(page: item_params[:page] || 1).as_json
      end

      private

      def item_params
        {
          page: params[:page] || 1,
          liked: params[:liked] == "true" || false,
          unliked: params[:unliked] == "true" || false,
          unrated: params[:unrated] == "true" || false
        }
      end
    end
  end
end
