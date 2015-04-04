require 'amazon_item_fetcher'

describe Services::Amazon::ItemFetcher do
  before do
    f = File.open(Rails.root + "spec/fixtures/amazon_response1.xml")
    @item = Amazon::Ecs::Response.new(f).items.first
    @fetcher = Services::ItemFetcher.new
  end

  it "#get_asin" do
    expect(@fetcher.get_asin(@item)).to eq "B0088WEN1O"
  end

  it "#get_price" do
    expect(@fetcher.get_price(@item)).to eq "$60.00"
  end

  describe "#get_action_url" do
    it "add to wishlist" do
      expect(@fetcher.get_action_url(@item, "Add To Wishlist")).to eq(
        "http://www.amazon.com/gp/registry/wishlist/add-item.html%3Fasin.0%3DB0088WEN1O%26SubscriptionId%3DAKIAIQW3RNVVQNECDDIA%26tag%3Dcodethiscod02-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB0088WEN1O"
      )
    end

    it "tell a friend" do
      expect(@fetcher.get_action_url(@item, "Tell A Friend")).to eq(
        "http://www.amazon.com/gp/pdp/taf/B0088WEN1O%3FSubscriptionId%3DAKIAIQW3RNVVQNECDDIA%26tag%3Dcodethiscod02-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB0088WEN1O"
      )
    end
  end

  it "#get_brand" do
    expect(@fetcher.get_brand(@item)).to eq "ASICS"
  end

  it "#get_url" do
    expect(@fetcher.get_url(@item)).to eq(
      "http://www.amazon.com/ASICS-GEL-VENTURE-4-M-Womens-GEL-Venture%C2%AE/dp/B0088WEN1O%3FSubscriptionId%3DAKIAIQW3RNVVQNECDDIA%26tag%3Dcodethiscod02-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB0088WEN1O"
    )
  end

  it "#get_image_url" do
    expect(@fetcher.get_image_url(@item)).to eq(
      "http://ecx.images-amazon.com/images/I/51GMGsRrXXL.jpg"
    )
  end

  it "#get_title" do
    expect(@fetcher.get_title(@item)).to eq"ASICS Women's GEL-Venture® 4"
  end
end
