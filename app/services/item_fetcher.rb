module Services
  class ItemFetcher
    def fetch_items(options)
      res = Amazon::Ecs.item_search(options[:search_string], 
        { response_group: 'OfferFull,Images,ItemAttributes', search_index: 'Shoes'})
      
      create_items(res)
    end
    
    def create_items(res)
      res.items.each do |response_item|
        item = Item.find_or_create_by(asin: get_asin(response_item)) 
        log = Log.new(
          success: true,
          total_pages: res.total_pages,
          page_fetched: res.item_page
        )
        
        begin
          log.asin = get_asin(response_item)
          item.title = get_title(response_item)
          item.image_url = get_image_url(response_item)
          item.url = get_url(response_item)
          item.brand = get_brand(response_item)
          item.price = get_price(response_item)
          item.wishlist_url = get_action_url(response_item, "Add To Wishlist")
          item.tell_friend_url = get_action_url(response_item, "Tell A Friend")
          item.save!
        rescue Exception => e
          log.json = Hash.from_xml(response_item.to_s)
          log.message = e.message
          log.success = false
        end
        
        log.save
      end
    end
    
    def get_asin(item)
      item.get_element('ASIN').get
    end
    
    def get_price(item)
      item.get_element('ListPrice').get('FormattedPrice')
    end  
    
    def get_action_url(item, type)
      url = ''
      links = Hash.from_xml(item.get_element('ItemLinks').to_s).deep_symbolize_keys
      item_link = links.fetch(:ItemLinks).fetch(:ItemLink)
      
      if item_link.respond_to?(:has_key?) && item_link.has_key?(:element)
        item_link = item_link.fetch(:element)
      end
        
      item_link.each do |link|
        url = link[:URL] if link.fetch(:Description) == type
      end
      
      url
    end
    
    def get_brand(item)
      item.get_element('ItemAttributes').get('Brand')
    end
    
    def get_url(item)
      item.get_element('DetailPageURL').get
    end
    
    def get_image_url(item)
      item.get_element('LargeImage').get('URL')
    end
    
    def get_title(item)
      item.get_element('ItemAttributes').get('Title')
    end
  end
end