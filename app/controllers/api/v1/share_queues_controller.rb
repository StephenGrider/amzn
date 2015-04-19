module Api
  module V1
    class ShareQueuesController < Api::V1::ApiController
      def index
        share_queues = ShareQueue.paginate(page: params[:page])
        share_queues = share_queues.created_by(current_user) if params[:created]
        share_queues = share_queues.received_by(current_user) if params[:received]

        render json: share_queues
      end

      private

      def validate_params
        param! :created, :boolean, default: false
        param! :received, :boolean, default: false
        param! :page, Integer, default: 1
      end
    end
  end
end
