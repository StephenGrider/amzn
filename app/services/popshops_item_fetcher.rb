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
            page: options[:page]
          }
        }
      end

      def do_request
        res = HTTParty.get("http://popshops.com/v3/products.json", @req_opts)
        parse_response res
        res
      end

      private

      def parse_response(res)
        return if res.code != 200
        json = JSON.parse(res.body)

        json["results"]["products"]["product"].each do |response_item|
          item = Item.find_or_create_by(asin: get_asin(response_item))
        end
      end

      def get_asin(item)
        item["id"]
      end
    end
  end
end
