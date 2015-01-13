module Services
  class ItemFetcher
    def self.create_items(options)
      res = Amazon::Ecs.item_search(options[:search_string], 
        { response_group: 'Medium', sort: 'salesrank'})
        
      if res.valid_request?
        res.items.each do |item|
          Item.create(
            title: item.get_element('ItemAttributes').get('Title'),
            price: item.get_hash('MediumImage')[:url]
          )
        end
      end
    end
  end
end