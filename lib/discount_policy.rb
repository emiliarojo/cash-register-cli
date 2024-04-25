# Abstract class for discount policies.
class DiscountPolicy
  def self.apply_discount(_quantity, _price)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
