module Api
  module V1
    class LineItemsController < ApplicationController
      def index
        @line_items = LineItem.paginate(:page => params[:page])
        render json: @line_items
      end
      
      def create
        line_item = current_user.line_items.new(params[:line_item])
        line_item.item = Item.where(params[:line_item][:item_id])
        
        if line_item.save
          render json: line_item
        else
          render :json => { errors: line_item.errors }
        end
      end
      
      def destroy
        line_item = LineItem.find(params[:id])
        if line_item.can_destroy?(current_user)
          line_item.destroy
        end
        
        render json: line_item
      end
    end
  end
end