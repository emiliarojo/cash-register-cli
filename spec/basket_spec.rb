require 'basket'
require 'product'
require 'discount'

RSpec.describe Basket do
  let(:discount) { instance_double('Discount') }
  let(:basket) { Basket.new(discount) }
  let(:green_tea) { Product.new('GR1') }
  let(:strawberries) { Product.new('SR1') }
  let(:coffee) { Product.new('CF1') }

  before do
    allow(discount).to receive(:apply)
  end

  describe '#add' do
    it 'adds a product to the basket' do
      basket.add(green_tea, 1)
      expect(basket.items).to include('GR1' => 1)
    end

    it 'increases the quantity of a product if already added' do
      2.times { basket.add(green_tea, 1) }
      expect(basket.items['GR1']).to eq(2)
    end

    it 'does not add a product if the quantity is non-positive' do
      basket.add(green_tea, 0)
      expect(basket.items).not_to include('GR1')
    end
  end

  describe '#remove' do
    it 'removes the specified quantity of a product from the basket' do
      basket.add(green_tea, 3)
      basket.remove(green_tea, 1)
      expect(basket.items['GR1']).to eq(2)
    end

    it 'removes the product from the basket if the remaining quantity is zero' do
      basket.add(green_tea, 1)
      basket.remove(green_tea, 1)
      expect(basket.items).not_to include('GR1')
    end

    it 'does nothing if the product to remove is not in the basket' do
      basket.remove(green_tea, 1)
      expect(basket.items).to be_empty
    end
  end

  describe '#total' do
    it 'calculates the total price of the basket without discounts' do
      basket.add(green_tea, 1)
      basket.add(strawberries, 1)
      basket.add(coffee, 1)

      allow(discount).to receive(:apply).and_return(green_tea.price, strawberries.price, coffee.price)

      expect(basket.total).to eq(green_tea.price + strawberries.price + coffee.price)
    end

    it 'calculates the total price with applicable discounts' do
      basket.add(green_tea, 2) # BOGO discount
      basket.add(strawberries, 3) # Bulk discount
      basket.add(coffee, 3) # Bulk discount

      allow(discount).to receive(:apply).with('GR1', 2, green_tea.price).and_return(green_tea.price)
      allow(discount).to receive(:apply).with('SR1', 3, strawberries.price).and_return(strawberries.price * 3)
      allow(discount).to receive(:apply).with('CF1', 3, coffee.price).and_return(coffee.price * 2)

      expected_total = green_tea.price + strawberries.price * 3 + coffee.price * 2
      expect(basket.total).to eq(expected_total)
    end
  end
end
