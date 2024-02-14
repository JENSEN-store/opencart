# Cypress Test Documentation: Select Product from Menu and Go to Cart

## Objective

The objective of this test is to verify that a user can select a product from the menu in an OpenCart demo project and successfully navigate to the shopping cart page.

## Prerequisites

- Node.js and npm installed on your machine.
- OpenCart demo project setup and running locally.

## Setup

### Install Cypress

```bash
npm install cypress --save-dev
```
### OpenCart Product Add to Cart Test Documentation
This README.md file documents a Cypress test that verifies the ability to successfully select a product and add it to the cart on the OpenCart demo site.

Test Name: OpenCart_ProductAddToCart

## Test Overview:

This test ensures users can navigate the OpenCart demo site, search for a product, select it, add it to their cart, and verify its presence in the cart.

## Prerequisites:

Cypress project: Set up a Cypress project with necessary configurations to access the OpenCart demo site.
OpenCart demo site: Ensure you have access to the OpenCart demo site at https://loachost:8080/.
Cypress knowledge: Basic understanding of Cypress testing concepts is recommended.
Running the Test:

Open your Cypress project: Start your Cypress project in a terminal or IDE.
Locate the test: Within the Cypress Test Runner, search for the OpenCart_ProductAddToCart test.
Run the test: Click the "Run" button to execute the test and observe the results.
## Expected Results:

The test should pass without errors.
The selected product should be added to the cart successfully.
The test should navigate to the cart page and confirm the product's presence.
Troubleshooting:

## Error messages: 
If the test fails, check the browser console for any error messages that might indicate the cause.
Site accessibility: Ensure the OpenCart demo site is accessible and functioning correctly.
Review steps and assertions: Carefully examine the test steps and assertions to pinpoint any potential issues.
Additional Considerations:

This test can be adapted to select different products, quantities, and handle scenarios like out-of-stock items.
Using selectors that are less susceptible to UI changes in OpenCart is recommended.
Consider implementing data-driven testing to cover various product categories and attributes.
Future Improvements:

Expand the test scope to cover user authentication, different product variations, and checkout flows.
Enhance documentation with screenshots or screen recordings for visual reference.
Integrate the test with CI/CD pipelines for automated regression testing.
