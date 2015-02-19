module Services
  module Popshops
    class ItemFetcher
      def initialize(options)
        @req_opts = {
          query: {
            account: "34n38shyj4y123ngozmvhkfis",
            catalog: "e5o3n125egw96por86dazlaey",
            results_per_page: "100",
            category: options[:category],
            page: options[:page],
            per_page: 100
          }
        }
      end

      def do_request
        res = HTTParty.get("http://popshops.com/v3/products.json", @req_opts)
        parse_response res
        "done"
      end

      private

      def parse_response(res)
        return if res.code != 200
        json = items(res)

        json.each do |response_item|

          log = Log.new(
            success: true
            page_fetched: get_page(res)
            total_pages: get_total_pages(res)
          )

          begin
            item = Item.find_or_create_by(asin: get_asin(response_item))
            item.title = get_title(response_item)
            item.price = get_price(response_item)
            item.image_url = get_image_url(response_item)
            item.url = get_url(response_item)
            # item.brand = get_brand(response_item) TODO: fix brand/brand_id
            item.save!
          rescue Exception => e
            log.message = e.message
            log.success = false
          end

          log.save
        end
      end

      def get_page(res)
        res["parameters"].select { |param| param["name"] == "page" }.first["value"]
      end

      def get_total_pages(res)
        (res["results"]["products"]["count"] / @req_opts["query"]["per_page"]).ceil
      end

      def items(res)
        JSON.parse(res.body)["results"]["products"]["product"]
      end

      def get_title(item)
        item["name"]
      end

      def get_brand_id(item)

      end

      def get_asin(item)
        item["id"]
      end

      def get_url(item)
        item["offers"]["offer"].first["url"]
      end

      def get_price(item)
        item["offers"]["offer"].first["price_merchant"]
      end

      def get_image_url(item)
        item["image_url_large"]
      end
    end
  end
end
