require 'open-uri'
require 'nokogiri'
# require 'net/http'
# require 'pp'
# require 'awesome_print'

# system('puts', 'http://www.amazon.com/Oreo-Chocolate-Sandwich-14-3-oz/dp/B0062Q5V32')

# url = 'https://jet.com/product/KOYO-Reduced-Sodium-Tofu-Miso-Ramen-Made-with-Organic-Noodles-2-Ounce-Pack-of-12/14186f907de74ed086eebd872ebe0486'
# url = 'http://www.rakuten.com/prod/canon-eos-rebel-t3-slr-camera-with-18-55mm-is-ii-lens-kit/220036283.html'

# page2 = Net::HTTP.get('amazon.com', '/Oreo-Chocolate-Sandwich-14-3-oz/dp/B0062Q5V32')

# # uri = URI('https://jet.com/product/KOYO-Reduced-Sodium-Tofu-Miso-Ramen-Made-with-Organic-Noodles-2-Ounce-Pack-of-12/14186f907de74ed086eebd872ebe0486')
# uri = URI('http://www.amazon.com/Oreo-Chocolate-Sandwich-14-3-oz/dp/B0062Q5V32')
# uri = 'http://www.rakuten.com/prod/canon-eos-rebel-t3-slr-camera-with-18-55mm-is-ii-lens-kit/220036283.html'
# page3 = Net::HTTP.get(uri)



# url = 'http://www.amazon.com/Oreo-Chocolate-Sandwich-14-3-oz/dp/B0062Q5V32'
# url = 'http://item.rakuten.co.jp/nishimatsuya/4971715490898-03/'
# url = 'http://item.rakuten.co.jp/sanesufitting/sssf-0012/'
# url = 'http://www.bestbuy.com/site/garmin-nvi-2689lmt-6-gps-with-built-in-bluetooth-lifetime-map-updates-and-lifetime-traffic-updates-black/8161028.p?id=1219314436515'
# url = 'http://www.bestbuy.com/site/whirlpool-25-4-cu-ft-side-by-side-refrigerator-with-thru-the-door-ice-and-water-monochromatic-stainless-steel/8244066.p?id=1218866280025&skuId=8244066'

url = gets.chomp
page = Nokogiri::HTML(open(url))
item_name = page.css("#sku-title").children.text
puts "name: #{item_name}"
unless page.css(".item-price").empty?
  price = page.css(".item-price").children.last.text.chomp
  puts "price: #{price}"
end
description = page.css("#long-description").children.text.chomp
puts "description: #{description}"


# response = Net::HTTP.get_response(URI.parse('http://www.amazon.com/adidas-Alliance-Sackpack-4-Inch-Black/dp/B00GV47ZGQ'))
# p response
# p response.code
# => "503"
# p response.body

# require 'net/http'
# # Must be somedomain.net instead of somedomain.net/, otherwise, it will throw exception.
# Net::HTTP.start("bestbuy.com") do |http|
#     resp = http.get("/site/frigidaire-gallery-24-tall-tub-built-in-dishwasher-with-stainless-steel-tub-stainless-steel/4122002.p?id=1219096319056")
#     open("text.txt", "wb") do |file|
#         file.write(resp.body)
#     end
# end
# puts "Done."
