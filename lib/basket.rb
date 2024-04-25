# Manages products and quantities in a shopping basket.
class Basket
  attr_reader :items

  def initialize
    @items = {} # Initializes the basket with an empty hash.
  end

  # Adds quantity of a product to the basket.
  def add(product, quantity)
    return if quantity < 1 # Skip adding if quantity is not positive.

    if @items.include?(product.code)
      @items[product.code] += quantity
    else
      @items[product.code] = quantity
    end
  end

  # Removes quantity of a product (removing the product completely if quantit to be removed exceeds current quantity).
  def remove(product, quantity)
    return unless @items.include?(product.code) # Skip if product not in basket.

    if quantity >= @items[product.code]
      @items.delete(product.code)
    else
      @items[product.code] -= quantity
    end
  end

  # Calculates the total price of the basket's contents and applies discounts.
  def total(discount)
    return 0 if @items.empty? # Return zero if the basket is empty.

    discount.apply_discounts(@items)
  end
end
