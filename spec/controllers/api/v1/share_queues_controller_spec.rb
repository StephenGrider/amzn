require 'spec_helper'

describe Api::V1::ShareQueuesController, :type => :controller do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe '#index' do
    before do
      @friend = create(:user)
      @created_share_queue = create(:share_queue, creator_id: @user.id, recipient_id: @friend.id)
      @received_share_queue = create(:share_queue, creator_id: @friend.id, recipient_id: @user.id)
    end

    context 'with no filters' do
      it 'returns all share queues related to the current user' do
        get :index

        share_queues = JSON.parse(response.body)
        expect(share_queues.length).to eq(2)
      end
    end

    context 'with creator filter' do
      it 'returns share_queues created by the current user' do
        get :index, created: true
        share_queues = JSON.parse(response.body)
        expect(share_queues.length).to eq(1)
        expect(share_queues[0]["id"]).to eq(@created_share_queue.id)
      end
    end

    context 'with recieved filter' do
      it 'returns share_queues received by the current user' do
        get :index, received: true
        share_queues = JSON.parse(response.body)
        expect(share_queues.length).to eq(1)
        expect(share_queues[0]["id"]).to eq(@received_share_queue.id)
      end
    end
  end
end
