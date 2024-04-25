require_relative 'discount_policy'

# Applies a bulk discount policy.
class BulkDiscountPolicy < DiscountPolicy
  def self.apply_discount(quantity, price, threshold, discount_price)
    quantity >= threshold ? quantity * discount_price : quantity * price
  end
end
