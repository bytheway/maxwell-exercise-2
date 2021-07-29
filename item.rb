class Item 
  attr_accessor :name, :unit_price, :sale_price, :sale_qty

  def initialize(name:, unit_price:, sale_price: nil, sale_qty: nil)
    @name = name
    @unit_price = BigDecimal(unit_price) unless unit_price.nil?
    @sale_price = BigDecimal(sale_price) unless sale_price.nil?
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
