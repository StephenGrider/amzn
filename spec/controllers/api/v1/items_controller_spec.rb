require 'spec_helper'

describe Api::V1::ItemsController, :type => :controller do
  before do
    @user = create(:user)

    @unliked_item = create(:item)
    LineItem.create(item_id: @unliked_item.id, user_id: @user.id, liked: false)

    @liked_item = create(:item)
    LineItem.create(item_id: @liked_item.id, user_id: @user.id, liked: true)

    @unrated_item = create(:item)

    sign_in @user
  end

  describe '#index' do
    context 'when no filter is passed' do
      it 'returns all items' do
        get :index
        expect(response).to be_success
        items = JSON.parse(response.body)

        expect(items.length).to eq(3)
        expect(items[0]["id"]).to eq(@unliked_item.id)
        expect(items[1]["id"]).to eq(@liked_item.id)
        expect(items[2]["id"]).to eq(@unrated_item.id)
      end
    end

    context "when filter 'liked' is provided" do
      it 'returns only liked items' do
        get :index, liked: 'true'
        expect(response).to be_success
        items = JSON.parse(response.body)

        expect(items.length).to eq(1)
        expect(items[0]["id"]).to eq(@liked_item.id)
      end
    end

    context "when filter 'disliked' is provided" do
      it 'returns only disliked items' do
        get :index, disliked: 'true'
        expect(response).to be_success
        items = JSON.parse(response.body)

        expect(items.length).to eq(1)
        expect(items[0]["id"]).to eq(@disliked_item.id)
      end
    end

    context "when filter 'unrated' is provided" do
      it 'returns only unrated items' do
        get :index, unrated: 'true'
        expect(response).to be_success
        items = JSON.parse(response.body)

        expect(items.length).to eq(1)
        expect(items[0]["id"]).to eq(@unrated_item.id)
      end
    end
  end
end
