describe Services::FetchManager do
  before do
    @search_node = SearchNode.create(vendor: 'Popshops', vendor_id: 1)
  end

  context 'when this node has never been fetched' do
    it 'fetches with options' do
      expect_any_instance_of(Services::Popshops::ItemFetcher).to receive(:initialize).with(page: 1, category: 1)
      Services::FetchManager.new.fetch
    end
  end

  context 'when this node has been fetched' do
    context 'and still has pages left' do
      before do
        Log.create(search_node_id: @search_node.id, page_fetched: 1, total_pages: 4)
      end

      it 'fetches with options' do
        expect_any_instance_of(Services::Popshops::ItemFetcher).to receive(:initialize).with(page: 2, category: 1)
        Services::FetchManager.new.fetch
      end
    end

    context 'and has no pages left' do
      before do
        Log.create(search_node_id: @search_node.id, page_fetched: 4, total_pages: 4)
      end

      it 'fetches with options' do
        expect_any_instance_of(Services::Popshops::ItemFetcher).to receive(:initialize).with(page: 1, category: 1)
        Services::FetchManager.new.fetch
      end
    end
  end
end
