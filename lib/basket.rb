# Manages products and quantities in a shopping basket.
class Basket
  attr_reader :items

  def initialize
    @items = {}  # Initializes the basket with an empty hash.
  end

  # Adds quantity of a product to the basket and applise discount alert if applicable.
  def add(product, quantity, discount = nil)
    return if quantity < 1  # Skip if quantity is not positive.

    current_quantity = @items.fetch(product.code, 0)
    new_quantity = current_quantity + quantity
    @items[product.code] = new_quantity

    alert_discount(product, new_quantity, discount) if discount
  end

  # Removes quantity of a product
  def remove(product, quantity, discount = nil)
    return unless @items.include?(product.code)  # Skip if product not in basket.

    remaining_quantity = @items[product.code] - quantity
    if remaining_quantity <= 0
      @items.delete(product.code) # Remove product from basket if quantity is zero or negative.
    else
      @items[product.code] = remaining_quantity
    end

    alert_discount(product, remaining_quantity, discount) if discount
  end

  # Alerts user if a discount is applied.
  def alert_discount(product, quantity, discount)
    rule = discount.rules_for(product.code)
    if rule && quantity >= rule[:threshold]
      puts "Discount applied on #{product.name}: #{rule[:description]}"
    end
  end

  # Calculates the total price of the basket's contents and applies any discounts.
  def total(discount)
    return 0 if @items.empty?

    @items.sum do |code, quantity|
      product = Product.new(code)
      discounted_price = discount.apply_discounts({code => quantity})
      puts "#{product.name}: Quantity: #{quantity}, Total Price: €#{'%.2f' % discounted_price}"
      discounted_price
    end
  end
end
