require 'rails_helper'

RSpec.describe ShareQueue, :type => :model do

  describe 'scopes' do
    before do
      @share_queue = build(:share_queue)
      @user = create(:user)
      @friend_user = create(:user)
    end

    describe '#created_by' do
      before do
        @share_queue.recipient_id = @friend_user.id
        @share_queue.creator_id = @user.id
        @share_queue.save
      end

      it 'returns share_queues that were created by given user' do
        share_queues = ShareQueue.created_by(@user)
        expect(share_queues).to eq([@share_queue])
      end
    end

    describe '#received_by' do
      before do
        @share_queue.recipient_id = @user.id
        @share_queue.creator_id = @friend_user.id
        @share_queue.save
      end

      it 'returns share_queues that were created by given user' do
        share_queues = ShareQueue.received_by(@user)
        expect(share_queues).to eq([@share_queue])
      end
    end
  end

  describe '#complete' do
    before do
      @share_queue = create(:share_queue, recipient_id: create(:user).id, creator_id: create(:user).id)
      @line_item1 = create(:line_item, share_queue_id: @share_queue.id)
      @line_item2 = create(:line_item, share_queue_id: @share_queue.id)
    end

    it 'is valid' do
      expect(@share_queue).to be_valid
    end

    context 'all of the queues line items have been reviewed' do
      before do
        @line_item1.update_attributes liked: true
        @line_item2.update_attributes liked: false
      end

      it 'returns true' do
        expect(@share_queue.complete?).to be true
      end
    end

    context 'none of the queues line items have been reviewed' do
      before do
        @line_item1.update_attributes liked: nil
        @line_item2.update_attributes liked: nil
      end

      it 'returns false' do
        expect(@share_queue.complete?).to be false
      end
    end

    context 'some of the queues line items have been reviewed' do
      before do
        @line_item1.update_attributes liked: true
        @line_item2.update_attributes liked: nil
      end

      it 'returns false' do
        expect(@share_queue.complete?).to be false
      end
    end
  end
end
