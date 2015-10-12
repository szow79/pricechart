helpers do

  def scrape(product_url)
    page = Nokogiri::HTML(open(product_url))
    # return false if page.css(".item-price").empty? items won't show price until added to cart
    properties = {
      name: page.css("#sku-title").children.text,
      price: page.css(".item-price").children.last.text.chomp,
      description: page.css("#long-description").children.text.chomp
    }
  end

  def system_record
    Item.all.each {|item|
     p item.url
    }
  end
end
