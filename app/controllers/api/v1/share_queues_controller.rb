module Api
  module V1
    class ShareQueuesController < Api::V1::ApiController
      def index
        share_queues = ShareQueue.paginate(page: params[:page])
        share_queues = share_queues.created_by(current_user) if params[:created]
        share_queues = share_queues.received_by(current_user) if params[:received]

        render json: share_queues
      end

      def create
        share_queue = build_queue

        render_json(share_queue, true)
      end

      private

      def build_queue
        attrs = { creator_id: current_user.id, recipient_id: params[:recipient_id] }
        share_queue = ShareQueue.create(attrs)

        ActiveRecord::Base.transaction do
          params[:item_ids].each { |item_id| find_or_build_line_item(share_queue.id, item_id) }
        end
        share_queue
      end

      def find_or_build_line_item(share_queue_id, item_id)
        line_item = LineItem.find_or_create_by(item_id: item_id, user_id: params[:recipient_id])
        line_item.liked = nil
        line_item.share_queue_id = share_queue_id
        line_item.save
      end

      def validate_params
        param! :created, :boolean, default: false
        param! :received, :boolean, default: false
        param! :page, Integer, default: 1
        param! :recipient_id, Integer
        param! :item_ids, Array
      end
    end
  end
end
