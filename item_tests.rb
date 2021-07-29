require 'rubygems'
require 'bundler/setup'
require 'bigdecimal'
require "test/unit"
require_relative "item"


  

# Cases to ensure the calculation is as expected, only give the sale prices on complete
# sales bundles, others get unit pricing
TEST_CASES = [
  {name: "1x", item: "test", sale_qty: 2, sale_price: "3", unit_price: "2", qty: 1, expected: "2"},
  {name: "2x", item: "test", sale_qty: 2, sale_price: "3", unit_price: "2", qty: 2, expected: "3"},
  {name: "3x", item: "test", sale_qty: 2, sale_price: "3", unit_price: "2", qty: 3, expected: "5"},
  {name: "4x", item: "test", sale_qty: 2, sale_price: "3", unit_price: "2", qty: 4, expected: "6"},
  {name: "5x", item: "test", sale_qty: 2, sale_price: "3", unit_price: "2", qty: 5, expected: "8"},
]

Class.new(Test::Unit::TestCase) do
  TEST_CASES.each do |c|
    define_method "test_item_#{c[:name]}" do
      i = Item.new(
      name: c[:name],
      unit_price: c[:unit_price],
      sale_price: c[:sale_price],
      sale_qty: c[:sale_qty],
      )
    
      assert_equal i.calculate_price(c[:qty]), BigDecimal(c[:expected])
    end
  end
end
