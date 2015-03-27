module Api
  module V1
    class ItemsController < Api::V1::ApiController
      def index
        items = Item.where(nil)
        items = items.liked_by(current_user) if item_params[:liked]
        items = items.liked_by(current_user) if item_params[:disliked]
        items = items.unrated_by(current_user) if item_params[:unrated]

        render json: items.paginate(page: item_params[:page]).as_json
      end

      private

      def item_params
        {
          page: params[:page] || 1,
          liked: params[:liked] == "true",
          disliked: params[:unliked] == "true",
          unrated: params[:unrated == "true"]
        }
      end
    end
  end
end
