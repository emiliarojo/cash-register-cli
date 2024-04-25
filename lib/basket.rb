require_relative 'product'
require_relative 'discount'

# Manages products and quantities in a shopping basket.
class Basket
  attr_reader :items

  def initialize(discount)
    @items = {}
    @discount = discount
  end

  # Add a product to the basket.
  def add(product, quantity)
    return if quantity <= 0

    @items[product.code] = (@items[product.code] || 0) + quantity # Add quantity to existing product or create new product in basket
  end

  # Remove a product from the basket.
  def remove(product, quantity)
    return unless @items.key?(product.code) && quantity > 0 # Check if product is in basket and quantity is positive

    @items[product.code] -= quantity # Remove quantity from product
    @items.delete(product.code) if @items[product.code] <= 0 # Remove product if quantity is zero or less
  end

  # Calculate the total price of the basket.
  def total
    @items.sum do |product_code, quantity|
      product = Product.new(product_code) # Create product object
      price = product.price # Get product price
      discount_amount = @discount.apply(product_code, quantity, price) if @discount # Apply discount if there's one applicable
      discount_amount || (price * quantity) # Return discount amount or total price if no discount
    end
  end
end
