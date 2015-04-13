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

  context '#last_page_fetched' do
    context 'search node still has pages left' do
      before do
        Log.create(search_node_id: @search_node.id, page_fetched: 1, total_pages: 4)
      end

      it 'fetches with options' do
        page = Services::FetchManager.new.send(:last_page_fetched, @search_node)
        expect(page).to eq 2
      end
    end

    context 'search node has no pages left' do
      before do
        Log.create(search_node_id: @search_node.id, page_fetched: 4, total_pages: 4)
      end

      it 'fetches with options' do
        page = Services::FetchManager.new.send(:last_page_fetched, @search_node)
        expect(page).to eq 1
      end
    end
  end
end
