describe('OpenCart CMS Test', () => {
  it('should select a product and add it to the cart', () => {
    // Visit the OpenCart demo site
    cy.visit('http://localhost:80/en-gb');

    // Navigate to the Desktops category
    cy.contains('Desktops').click();

    // Navigate to the Mac subcategory
    cy.contains('Mac (1)').click();  // Adjust the index based on your site's actual content

    // Find and click on the iMac product
    cy.contains('iMac').click();

    // Verify that the product page is loaded
    cy.url().should('include', 'product/desktops/mac/imac');

    // Add the product to the cart using a more specific selector
    cy.get('#button-cart').click();

    // Wait for the success message
    cy.get('#alert').should('contain', 'Success: You have added');

    //close the alert
    cy.get('.btn-close').click();

    // Navigate to the shopping cart
    cy.get('.dropdown > .btn-lg').click();

    // Verify that the product is in the shopping cart
    cy.get('#content').should('contain', 'iMac');
  });
});
