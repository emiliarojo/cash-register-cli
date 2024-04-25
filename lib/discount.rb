# Manages the application of discount policies for products.
class Discount
  def initialize
    @policies = {
      'GR1' => ->(quantity, price) { BogoDiscountPolicy.apply_discount(quantity, price) },
      'SR1' => ->(quantity, price) { BulkDiscountPolicy.apply_discount(quantity, price, 3, 4.50) },
      'CF1' => ->(quantity, price) { BulkDiscountPolicy.apply_discount(quantity, price, 3, price * 2 / 3) }
    }
  end

  # Apply specific discount policy for a product.
  def apply(product_code, quantity, price)
    policy = @policies[product_code]
    policy.call(quantity, price) if policy
  end
end
