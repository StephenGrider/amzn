module Admin
  class AmazonItemsController < ApplicationController
    def index
      
    end
    
    def search
      res = Amazon::Ecs.item_search("shoes", 
        { response_group: 'Offers,ItemAttributes,Images', search_index: 'Shoes'})
      
      render json: Hash.from_xml(res.doc.to_s)
    end
  end
end