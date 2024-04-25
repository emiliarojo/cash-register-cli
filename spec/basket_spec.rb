# require 'basket'
# require 'product'
# require 'discount'

# RSpec.describe Basket do
#   let(:basket) { Basket.new }
#   let(:green_tea) { Product.new('GR1') }
#   let(:coffee) { Product.new('CF1') }
#   let(:strawberries) { Product.new('SR1') }
#   let(:discount) { Discount.new }

#   describe '#add' do
#     it 'does not add a product when the quantity is zero' do
#       expect { basket.add(green_tea, 0) }.not_to change { basket.items.length }
#     end

#     it 'does not add a product when the quantity is negative' do
#       expect { basket.add(green_tea, -1) }.not_to change { basket.items.length }
#     end
#   end

#   describe '#remove' do
#     context 'when removing more items than are in the basket' do
#       before { basket.add(green_tea, 1) }

#       it 'removes the item completely' do
#         expect { basket.remove(green_tea, 2) }.to change { basket.items.length }.from(1).to(0)
#       end
#     end

#     context 'when trying to remove an item not in the basket' do
#       it 'does nothing' do
#         expect { basket.remove(coffee, 1) }.not_to change { basket.items.length }
#       end
#     end
#   end

#   describe '#total' do
#     context 'with an empty basket' do
#       it 'returns zero' do
#         expect(basket.total(discount)).to eq(0)
#       end
#     end

#     context 'with multiple products and discounts' do
#       before do
#         basket.add(green_tea, 2) # Should apply BOGO
#         basket.add(coffee, 3) # Should apply bulk (2/3 price)
#         basket.add(strawberries, 3) # Should apply bulk (4.50)
#       end

#       it 'calculates the total with all applicable discounts' do
#         expected_total = (2 * 3.11 / 2) + (3 * (11.23 * 2 / 3) + (3 * 4.50))
#         expect(basket.total(discount)).to be_within(0.01).of(expected_total)
#       end
#     end
#   end
# end
