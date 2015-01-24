module Api
  module V1
    class ItemsController < Api::V1::ApiController
      def index
        json = Item.paginate(page: params[:page]).to_json
        
        if params[:filters][:liked]
          json = Item.liked_by(current_user).paginate(page: params[:page]).to_json
        elsif params[:filters][:unseen]
          json = Item.unrated_by(current_user).paginate().to_json
        end
        
        render json: json
      end
    end
  end
end
