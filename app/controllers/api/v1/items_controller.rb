module Api
  module V1
    class ItemsController < Api::V1::ApiController
      def index
        items = Item.where(nil)
        items = items.liked_by(current_user) if params[:liked]
        items = items.disliked_by(current_user) if params[:disliked]
        items = items.unrated_by(current_user) if params[:unrated]

        render json: items.paginate(page: params[:page]).as_json
      end

      private

      def validate_params
        param! :page, Integer, default: 1
        param! :liked, :boolean
        param! :disliked, :boolean
        param! :unrated, :boolean
      end
    end
  end
end
