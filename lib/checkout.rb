require_relative 'product'
require_relative 'basket'
require_relative 'discount'
require_relative 'bogo_discount_policy'
require_relative 'bulk_discount_policy'

# The Checkout class handles interactions during the checkout process.
class Checkout
  def initialize(discount_policy)
    @discount = discount_policy
    @basket = Basket.new(@discount)
    @products = {
      'GR1' => Product.new('GR1'),
      'SR1' => Product.new('SR1'),
      'CF1' => Product.new('CF1')
    }
  end

  def start
    loop do
      puts "\nChoose an option:"
      puts "1. Scan product"
      puts "2. Remove product"
      puts "3. Show total"
      puts "4. Exit"
      input = gets.strip.to_i

      case input
      when 1
        scan_product
      when 2
        remove_product
      when 3
        show_total
      when 4
        puts "Exiting!"
        break
      else
        puts "Invalid option, try again."
      end
    end
  end

  private

  def scan_product
    list_products
    product_index = gets.strip.to_i - 1
    if product_index.between?(0, @products.size - 1)
      selected_product = @products.values[product_index]
      puts "Enter quantity to scan:"
      quantity = gets.strip.to_i
      if quantity > 0
        @basket.add(selected_product, quantity)
        puts "Added #{quantity} of #{selected_product.name} to your basket."
      else
        puts "Invalid quantity entered."
      end
    else
      puts "Invalid selection, please try again."
    end
    display_basket
  end

  def remove_product
    if @basket.items.empty?
      puts "Your basket is currently empty."
      return
    end
    list_basket_contents
    product_index = gets.strip.to_i - 1
    if product_index.between?(0, @basket.items.size - 1)
      selected_code = @basket.items.keys[product_index]
      selected_product = @products[selected_code]
      puts "Enter quantity to remove:"
      quantity = gets.strip.to_i
      if quantity > 0
        @basket.remove(selected_product, quantity)
        puts "Removed #{quantity} of #{selected_product.name} from your basket."
      else
        puts "Invalid quantity entered."
      end
    else
      puts "Invalid selection, please try again."
    end
    display_basket
  end


  def show_total
    total = @basket.total
    puts "\nTotal due: €#{'%.2f' % total}"
    display_basket
  end

  def display_basket
    puts "\nBasket Contents:"
    if @basket.items.empty?
      puts "Your basket is empty."
    else
      @basket.items.each do |code, quantity|
        product = @products[code]
        total_price = quantity * product.price
        puts "#{product.name}: Quantity: #{quantity}, Price: €#{'%.2f' % total_price}"
      end
      total = @basket.total
      puts "Total due: €#{'%.2f' % total}"
    end
  end

  def list_products
    puts "Select a product to scan:"
    @products.each_with_index do |(code, product), index|
      puts "#{index + 1}. #{product.name} - €#{product.price}"
    end
  end

  def list_basket_contents
    puts "Select a product to remove:"
    if @basket.items.empty?
      puts "Your basket is currently empty."
    else
      @basket.items.each_with_index do |(code, quantity), index|
        product = @products[code]
        puts "#{index + 1}. #{product.name} (Quantity: #{quantity})"
      end
    end
  end
end


# Run the checkout process.
discount = Discount.new
checkout = Checkout.new(discount)
checkout.start
