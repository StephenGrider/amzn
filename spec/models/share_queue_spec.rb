require 'rails_helper'

RSpec.describe ShareQueue, :type => :model do
  describe '#complete' do
    before do
      @line_item1 = create(:line_item)
      @line_item2 = create(:line_item)

      creator = create(:user)
      recipient = create(:user)

      @share_queue = build(:share_queue)
      @share_queue.recipient_id = recipient.id
      @share_queue.creator_id = creator.id
    end

    it 'is valid' do
      expect(@share_queue).to be_valid
    end

    context 'all of the queues line items have been reviewed' do
      before do
        @line_item1.liked = true
        @line_item2.liked = false
      end

      it 'returns true' do
        expect(@share_queue.complete?).to be true
      end
    end

    context 'none of the queues line items have been reviewed' do
      it 'returns false' do
        expect(@share_queue.complete?).to be false
      end
    end

    context 'some of the queues line items have been reviewed' do
      before do
        @line_item1.liked = true
      end

      it 'returns false' do
        expect(@share_queue.complete?).to be false
      end
    end
  end
end
