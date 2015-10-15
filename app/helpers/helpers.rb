helpers do

  def digitize(str)
    str.scan(/\d/).join.to_i      
  end

  def scrape(product_url)
    page = Nokogiri::HTML(open(product_url))
    # return false if page.css(".item-price").empty? items won't show price until added to cart
    properties = {
      url: product_url,
      name: page.css("#sku-title").children.text,
      price: digitize(page.css(".item-price").children.last.text.chomp),
      description: page.css("#long-description").children.text.chomp
    }
  end

  def system_record
    Item.all.each do |item|
      page = Nokogiri::HTML(open(item.url))
      price = digitize(page.css(".item-price").children.last.text.chomp)
      item.records.create(price: price)
    end
  end
end
