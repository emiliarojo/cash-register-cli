# Manages application of discount rules for products in the basket.
class Discount
  def initialize
    # Defines discount rules: type, threshold, and adjustments for each product.
    @rules = {
      'GR1' => { type: 'bogo_discount', threshold: 1, description: 'Buy one get one free on Green Tea' },
      'SR1' => { type: 'bulk_discount', threshold: 3, discount_price: 4.50, description: 'Discount for buying 3 or more Strawberries' },
      'CF1' => { type: 'bulk_discount', threshold: 3, discount_price: 7.49, description: 'Discount for buying 3 or more Coffees' }
    }
  end

  # Calculates the total price for items in the cart and applies appropriate discounts.
  def apply_discounts(basket_items)
    total = 0
    basket_items.each do |code, quantity|
      price = Product::PRICES[code]
      if price
        rule = @rules[code]
        total += rule ? send(rule[:type], quantity, price, rule) : quantity * price # Applies discount if rule exists or uses normal price.
      end
    end
    total
  end

  # Provides access to specific discount rules by product code.
  def rules_for(code)
    @rules[code]
  end

  private

  def bogo_discount(quantity, price, rule)
    (quantity / 2 + quantity % 2) * price
  end

  def bulk_discount(quantity, price, rule)
    quantity >= rule[:threshold] ? quantity * rule[:discount_price] : quantity * price
  end
end
