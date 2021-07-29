class Cart
    attr_accessor :cart_items, :price_list

    def initialize(price_list)
        @price_list = price_list
        @cart_items = {}
    end

    # Adds an item to the cart. Each additional addition increases the qty of that 
    # item in the cart.
    def add_item(name)
        @cart_items[name] ||= 0
        @cart_items[name] += 1
    end

    # Print a tabular receipt to the screen. This is currently a fixed column-width
    # table and overflows are assumed to never happen.
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

            print "$#{price.to_s("2F")}"
            puts
        end

        puts
        puts "Total price : $#{total_price.to_s("2F")}"

        if total_price < total_retail_price
            puts "You saved $#{(total_retail_price - total_price).to_s("2F")} today."
        end

        puts
    end
end