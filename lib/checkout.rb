require_relative 'product'
require_relative 'basket'
require_relative 'discount'
require_relative 'bogo_discount_policy'
require_relative 'bulk_discount_policy'

# The Checkout class handles user interactions during the checkout process.
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

  # Starts the checkout process and allows user to scan products, remove products, show total, or exit.
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

  # Scans a product and adds it to the basket. Also alerts user to any discounts applied.
  def scan_product
    list_products # List all products for user to select.
    product_index = gets.strip.to_i - 1

    if product_index.between?(0, @products.size - 1)
      # Select product from list.
      selected_product = @products.values[product_index]
      # Ask user for quantity of product to add.
      puts "Enter quantity to scan:"
      quantity = gets.strip.to_i
      # Add product to basket if quantity is valid.
      if quantity > 0
        @basket.add(selected_product, quantity)
        puts "\nAdded #{quantity} #{selected_product.name} to your basket."
        alert_discount(selected_product.code, quantity) # Alert user about applicable discount immediately after adding the item.
      else
        puts "Invalid quantity entered."
      end
    else
      puts "Invalid selection, please try again."
    end
    display_basket # Display updated basket contents.
  end

  # Removes a product from the basket and alerts user to any changes in discounts.
  def remove_product
    if @basket.items.empty?
      puts "Your basket is currently empty."
      return
    end
    list_basket_contents # List all products in basket for user to select.
    product_index = gets.strip.to_i - 1
    if product_index.between?(0, @basket.items.size - 1)
      # Select product from basket.
      selected_code = @basket.items.keys[product_index]
      selected_product = @products[selected_code]
      # Ask user for quantity of product to remove.
      puts "Enter quantity to remove:"
      quantity = gets.strip.to_i
      # Remove product from basket if quantity is valid.
      if quantity > 0
        @basket.remove(selected_product, quantity)
        puts "\nRemoved #{quantity} #{selected_product.name} from your basket."
      else
        puts "Invalid quantity entered."
      end
    else
      puts "Invalid selection, please try again."
    end
    display_basket # Display updated basket contents.
  end

  # Displays the total price of the basket with a breakdown of discounts applied to each product.
  def show_total
    total = @basket.total
    puts "\nTotal due: €#{'%.2f' % total}"
  end

  # Displays the contents of the basket, including discounted prices and total.
  def display_basket
    puts "\nBasket:"
    if @basket.items.empty?
      puts "Your basket is empty."
    else
      @basket.items.each do |code, quantity|
        product = @products[code]
        discounted_total_price = @discount.apply(code, quantity, product.price)
        discounted_unit_price = discounted_total_price / quantity
        puts "#{product.name}: Quantity: #{quantity}, Price: €#{'%.2f' % discounted_unit_price} each, Total: €#{'%.2f' % discounted_total_price}"
      end
    show_total
    end
  end

  # Alerts the user if a discount has been applied after adding a productt.
  def alert_discount(product_code, quantity)
    discount_amount = @discount.apply(product_code, quantity, @products[product_code].price)
    if discount_amount && discount_amount != @products[product_code].price * quantity
      puts "\nDiscount applied! New price for #{@products[product_code].name} is €#{'%.2f' % (discount_amount / quantity)} each."
    end
  end

  # Lists all products that the user can scan.
  def list_products
    puts "\nSelect a product to scan:"
    @products.each_with_index do |(code, product), index|
      puts "#{index + 1}. #{product.name} - €#{product.price}"
    end
  end

  # Lists contents of the basket for user to select which product to remove.
  def list_basket_contents
    puts "\nSelect a product to remove:"
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

# To run the checkout process and CLI test.
if __FILE__ == $PROGRAM_NAME
  discount = Discount.new
  checkout = Checkout.new(discount)
  checkout.start
end
