require 'aruba/rspec'
require 'pathname'

RSpec.describe 'Checkout CLI', type: :aruba do
  let(:root_path) { Pathname.new(File.dirname(__FILE__)).join('..') }
  let(:script_path) { root_path.join('lib', 'checkout.rb').to_s }

  before do
    setup_aruba
    Aruba.configure do |config|
      config.exit_timeout = 30 # Timeout for slow response
    end
  end

  it 'completes a checkout process with discounts correctly applied' do
    run_command("ruby #{script_path}")
    type('1') # Scan product
    type('1') # Select Greeen Tea
    type('2') # Enter quantity: 2 (BOGO discount)
    type('1') # Scan product
    type('2') # Select Strawberries
    type('3') # Enter quantity: 3 (bulk discount)
    type('1') # Scan product
    type('3') # Select Coffee
    type('3') # Enter quantity: 3 bulk discount
    type('2') # Remove product
    type('1') # Select Green Tea
    type('1') # Enter quantity: 1
    type('3') # Show total
    type('4') # Exit checkout
    stop_all_commands

    expected_total = 3.11 + (4.50 * 3) + (11.23 * 2 / 3 * 3)
    expect(last_command_stopped.output).to include("Total due: €#{format('%.2f', expected_total)}")
  end
end
