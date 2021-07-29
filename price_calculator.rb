require 'rubygems'
require 'bundler/setup'
require 'bigdecimal'
require_relative 'item'
require_relative 'cart'


items = {}
items['milk'] = Item.new(name: 'Milk', unit_price: "3.97", sale_price: "5.00", sale_qty: 2 )
items['bread'] =  Item.new(name: 'Bread', unit_price: "2.17", sale_price: "6.00", sale_qty: 3 )
items['banana'] =Item.new(name: 'Banana', unit_price: "0.99")
items['apple'] = Item.new(name: 'Apple', unit_price: "0.89")

puts "Please enter all the items purchased separated by a comma"

input = gets.chomp

input = input.split(",").map{|i| i.strip}

cart = Cart.new(items)

input.each do |i|
    next if i.nil? || i.empty?
    cart.add_item(i)
end

cart.print_receipt
