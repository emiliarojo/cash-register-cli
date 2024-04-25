require 'bogo_discount_policy'

RSpec.describe BogoDiscountPolicy do
  describe '.apply_discount' do
    it 'applies a buy-one-get-one-free discount' do
      expect(BogoDiscountPolicy.apply_discount(2, 3.11)).to eq(3.11)
      expect(BogoDiscountPolicy.apply_discount(1, 3.11)).to eq(3.11)
      expect(BogoDiscountPolicy.apply_discount(3, 3.11)).to eq(3.11 * 2)
    end
  end
end
