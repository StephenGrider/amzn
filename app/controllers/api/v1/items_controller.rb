module Api
  module V1
    class ItemsController < Api::V1::ApiController
      def index
        json = Item.paginate(page: item_params[:page] || 1).to_json
        if item_params[:liked]
          json = Item.liked_by(current_user).paginate(page: params[:page] || 1).to_json
        elsif item_params[:unrated]
          json = Item.unrated_by(current_user).paginate(page: params[:page]).to_json
        end

        render json: json
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
