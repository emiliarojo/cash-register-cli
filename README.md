# Cash Register CLI Application

## Introduction 🍵 🍓 ☕️
This Cash Register application is an OOP Ruby command-line program designed to simulate a basic cash register. It supports adding and removing products from a shopping basket, calculates totals with dynamic discounts, and provides a simple interface for managing transactions.

## Features
- **Add Products**: Scan products to add them to the shopping basket.
- **Remove Products**: Remove products from the basket.
- **Dynamic Discounts**: Supports buy-one-get-one-free offers and bulk purchase discounts.
- **Command Line Interface**: Utilizes a simple command-line interface for interaction.

## Prerequisites
To run this application, you need:
- Ruby (version 2.5 or higher). Verify your Ruby installation by running `ruby -v` in your command line.
- Bundler for managing Ruby gems. Install Bundler with `gem install bundler`, if it's not already installed.

## Installation
1. Clone the repository to your local machine:

    `git clone https://github.com/emiliarojo/cash-register-cli.git`

2. Navigate to the project directory:

    `cd cash-register-cli`

3. Install the required gems for testing:

    `bundle install`

## Use
To start the application, run the following Rake task:

  `rake run`

Follow the prompts to interact with the program:

1. **Scan Product**: Add a product by selecting it from the list.
2. **Remove Product**: Remove a product by selecting it from the list.
3. **Show Total**: Display the total price, including any discounts.
4. **Exit**: Exit the application.

## Testing
Run the automated tests for this application using the following command:

  `rake spec`

These tests utilize RSpec and Aruba to ensure functionality works as expected.

## How It Works
### Components
- **Product**: Represents a product with a unique code, name, and price.
- **Basket**: Manages the shopping basket, tracking products and quantities.
- **Discount**: Calculates discounts based on predefined rules.
- **Checkout**: Manages user interactions, product scanning, and basket management.

### Discounts
The application currently supports these types of discounts:

- Buy-One-Get-One-Free (BOGO) for specific items.
- Bulk Purchase Discounts: Reduces the price when the quantity reaches a specific threshold.

## UML Diagram
![cash_register_cli_uml](https://github.com/emiliarojo/cash-register-cli/assets/115421477/e1111be5-b579-43fc-885d-86952f282d3a)
