# opencart

Running OpenCart Demo Site on Localhost with Bitnami Docker Image
Introduction
This guide will walk you through the steps of running an OpenCart demo site on your local machine using the Bitnami Docker image for OpenCart. OpenCart is an open-source eCommerce platform that is widely used to create online stores. Bitnami provides pre-packaged Docker images for many popular applications, including OpenCart, making it easy to get started with their deployment.

Requirements
Before you begin, you will need to have the following installed on your system:

Docker Engine: Install Docker on your system according to the instructions for your operating system.
Docker Compose: Install Docker Compose, which is a tool for defining and running multi-container Docker applications.
Setting Up the OpenCart Demo Site
Clone the Bitnami OpenCart Docker repository:
Bash
git clone https://github.com/bitnami/bitnami-docker-opencart.git
Use code with caution. Learn more
Change directory to the cloned repository:
Bash
cd bitnami-docker-opencart
Use code with caution. Learn more
Create a .env file and add the following environment variables:
OPENCART_ADMIN_USERNAME=admin
OPENCART_ADMIN_PASSWORD=password
Start the OpenCart demo site using Docker Compose:
Bash
docker-compose up -d
Use code with caution. Learn more
Open the OpenCart demo store in your web browser by navigating to http://localhost:8080.

Log in to the OpenCart admin panel using the credentials you set in the .env file.

Accessing the OpenCart Demo Store
Once the OpenCart demo site is running, you can access it in your web browser by navigating to http://localhost:8080. You will be presented with the OpenCart homepage.

Admin Panel Access
To access the OpenCart admin panel, click on the "My Account" link in the top right corner of the homepage. Then, click on the "Login" button and enter the credentials you set in the .env file.

Modifying the Demo Site
You can make changes to the OpenCart demo site by logging in to the admin panel. You can customize the store's appearance, add products, and configure various settings.

Stopping and Removing the Demo Site
To stop the OpenCart demo site, run the following command:

Bash
docker-compose down
Use code with caution. Learn more
To remove all Docker images and containers associated with the OpenCart demo site, run the following command:

Bash
docker system prune -a
Use code with caution. Learn more
Conclusion
This guide has provided you with the steps on how to run an OpenCart demo site on your local machine using the Bitnami Docker image. With this setup, you can easily experiment with OpenCart and explore its features without having to deploy it to a production server.
