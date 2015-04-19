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

  describe '#create' do
    before do
      @friend = create(:user)
      @item = create(:item)

      @attrs = {
        creator_id: @user.id,
        recipient_id: @friend.id,
        item_ids: [@item.id]
      }
    end

    it 'creates a new queue' do
      expect {
        post :create, @attrs
      }.to change(ShareQueue, :count).by(1)
    end

    it 'creates a queue with correct attributes' do
      post :create, @attrs

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["creator_id"]).to eq(@user.id)
      expect(parsed_response["recipient_id"]).to eq(@friend.id)
    end

    it 'creates a line_item' do
      expect {
        post :create, @attrs
      }.to change(LineItem, :count).by(1)

      expect(LineItem.all.last.item_id).to eq(@item.id)
    end

    context 'recipient has already reviewed this item' do
      before do
        @line_item = LineItem.create(user_id: @friend.id, item_id: @item.id, liked: true)
      end

      it 'clears the liked property' do
        expect {
          post :create, @attrs
        }.to change(LineItem, :count).by(0)

        @line_item.reload
        expect(@line_item.liked).to be_nil
        expect(ShareQueue.all.last.line_items[0]).to eq(@line_item)
      end
    end
  end
end
