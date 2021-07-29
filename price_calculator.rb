
class Item 
  attr_accessor :name, :unit_price, :sale_price, :sale_qty

  def initialize(name:, unit_price:, sale_price: nil, sale_qty: nil)
    @name = name
    @unit_price = unit_price
    @sale_price = sale_price
    @sale_qty = sale_qty
  end


  def calculate_price(qty)
    if @sale_price.nil? || @sale_qty.nil?
        return retail_price(qty)
    end

    bundles = qty / @sale_qty
    retail = qty % @sale_qty

    return (bundles * @sale_price) + retail_price(retail)
  end

  def retail_price(qty)
    return qty * @unit_price
  end
end

class Cart
    attr_accessor :cart_items, :price_list

    def initialize(price_list)
        @price_list = price_list
        @cart_items = {}
    end

    def add_item(name)
        @cart_items[name] ||= 0
        @cart_items[name] += 1
    end

    def print_receipt
        total_price = 0
        total_retail_price = 0

        puts
        puts "Item     Quantity      Price"
        puts "--------------------------------------"
        @cart_items.each do |name, qty|

            item = @price_list[name]
            price = item.calculate_price(qty)
            total_price += price
            total_retail_price += item.retail_price(qty)

            print item.name
            print " " * (9 - item.name.length)

            print qty
            print " " * (14 - qty.to_s.length)

            print "$#{price}"
            puts
        end

        puts
        puts "Total price : $#{total_price}"

        if total_price < total_retail_price
            puts "You saved $#{total_retail_price - total_price} today."
        end

        puts
    end
end

items = {}
items['milk'] = Item.new(name: 'Milk', unit_price: 3.97, sale_price: 5, sale_qty: 2 )
items['bread'] =  Item.new(name: 'Bread', unit_price: 2.17, sale_price: 6, sale_qty: 3 )
items['banana'] =Item.new(name: 'Banana', unit_price: 0.99)
items['apple'] = Item.new(name: 'Apple', unit_price: 0.89)

puts "Please enter all the items purchased separated by a comma"

input = gets.chomp

input = input.split(",").map{|i| i.strip}

cart = Cart.new(items)

input.each do |i|
    next if i.nil? || i.empty?
    cart.add_item(i)
end

cart.print_receipt
