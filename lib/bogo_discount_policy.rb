require_relative '../lib/discount_policy'

# Applies a Buy-One-Get-One discount policy.
class BogoDiscountPolicy < DiscountPolicy
  def self.apply_discount(quantity, price)
    (quantity / 2 + quantity % 2) * price
  end
end
