module Api
  module V1
    class LineItemsController < Api::V1::ApiController
      def index
        @line_items = LineItem.paginate(page: params[:page])
        render json: @line_items
      end

      def create
        attrs = { liked: params[:liked], item_id: params[:item_id] }
        line_item = current_user.line_items.build(attrs)

        render_json(line_item, line_item.save && current_user.id == line_item.user_id)
      end

      def update
        line_item = LineItem.find_by_id(params[:id])

        render_json(line_item, line_item.update_attributes(liked: params[:liked]))
      end

      def destroy
        line_item = LineItem.find_by_id(params[:id])
        if line_item.can_destroy?(current_user)
          line_item.destroy
        end

        render json: line_item
      end

      private

      def validate_params
        param! :id, Integer
        param! :item_id, Integer
        param! :liked, :boolean
        param! :page, Integer, default: 1
      end
    end
  end
end
