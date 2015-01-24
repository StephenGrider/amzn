module Api
  module V1
    class LineItemsController < Api::V1::ApiController
      def index
        @line_items = LineItem.paginate(page: params[:page])
        render json: @line_items
      end
      
      def create
        line_item = current_user.line_items.build(liked: line_item_params[:liked])
        line_item.item = Item.find_by_id(line_item_params[:item_id])
        
        if line_item.save && current_user.id == line_item.user_id
          render json: { line_item: line_item }
        else
          render json: { errors: line_item.errors }, status: 422
        end
      end
      
      def destroy
        line_item = LineItem.find_by_id(params[:id])
        if line_item.can_destroy?(current_user)
          line_item.destroy
        end
        
        render json: { line_item: line_item }
      end
      
      private
      
      def line_item_params
        params.require(:line_item).permit(:item_id, :liked)
      end
    end
  end
end