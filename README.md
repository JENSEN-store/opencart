# opencart

Setting Up the OpenCart Demo Site
Running OpenCart Demo Site on Localhost with Bitnami Docker Image

## Introduction

This guide will walk you through the steps of running an OpenCart demo site on your local machine using the Bitnami Docker image for OpenCart. OpenCart is an open-source eCommerce platform that is widely used to create online stores. Bitnami provides pre-packaged Docker images for many popular applications, including OpenCart, making it easy to get started with their deployment.

## Requirements

Before you begin, you will need to have the following installed on your system:

Docker Engine: Install Docker on your system according to the instructions for your operating system.
Docker Compose: Install Docker Compose, which is a tool for defining and running multi-container Docker applications.

## Setting Up the OpenCart Demo Site

#### Clone the Bitnami OpenCart Docker repository:

```
git clone https://github.com/bitnami/bitnami-docker-opencart.git
```

Use code with caution. Learn more

#### Change directory to the cloned repository:

```
cd bitnami-docker-opencart
```

Use code with caution. Learn more

#### Create a .env file and add the following environment variables:

OPENCART_ADMIN_USERNAME=admin
OPENCART_ADMIN_PASSWORD=password

#### Start the OpenCart demo site using Docker Compose:

```
docker-compose up -d
```

Use code with caution. Learn more

#### Open the OpenCart demo store in your web browser by navigating to http://localhost:8080.

Log in to the OpenCart admin panel using the credentials you set in the .env file.

#### Accessing the OpenCart Demo Store

Once the OpenCart demo site is running, you can access it in your web browser by navigating to http://localhost:8080. You will be presented with the OpenCart homepage.

## Kubernetes Deployment

This instance of OpenCart has also been deployed on an Ubuntu server running a **microK8s** single node cluster. The manifests needed to deploy to the cluster were provided through **Terraform**, with some additional config needed. The guide assumes a basic knowledge of Kubernetes. 

### Creating and Deploying the Cluster:

The **microK8s** cluster was created using the documentation provided by their [website](https://microk8s.io/docs), along with some additional configurations, described below:

#### Configuring the cluster

After installing **microK8s**, the following steps were taken:

#### Open firewall ports

In order for all the services and addons to work properly, some ports need to be opened. The ports needed are listed in the [microK8s documentation](https://microk8s.io/docs/services-and-ports).

These ports were then opened in the firewall using:
```
ufw allow [PORT_NUMBER]
```

#### Set context

In order to set kubectl context to microk8s, run the following commands:

```
cd ~/.kube
microk8s config > config
```

#### Enable addons

```
microk8s enable cert-manager dns ingress metallb:[HOST_IP-HOST_IP]
```

The mentioned addons provide you with the ability to run an NGINX Controller index and Load Balancer, as well as TLS certificates for your deployment. The `HOST_IP` variable relates to the IP-address of the host machine, used to relay traffic into the pods.

#### Create Cluster Issuer

A Cluster issuer is needed in order to get the TLS certificate, which can be applied using [K8s-manifests/letsencrypt.yml](https://github.com/JENSEN-store/opencart/blob/217860c63d3ad0d2d73d51268979df723d8de58b/K8s-manifests/letsencrypt.yml). Before applying, change the email address to a valid personal one.

```
kubectl apply -f K8s-manifests/letsencrypt.yml
```

#### Expose NGINX Controller

In order to successfully use the NGINX Controller as a Load Balancer, we need to expose the pod, which can be done using the following command:

```
kubectl get pods -n ingress
kubectl expose pod [POD_NAME] --port 80 --type LoadBalancer -n ingress
```
`POD_NAME` refers to the name of the nginx controller pod, which is shown by the first command. 

#### Terraform Plan and Apply
When the **microK8s** cluster is configured to your liking, the terraform script can be run:

```
terraform init
terraform plan
terraform apply
```

## Build and Deploy workflow

The build and deploy workflow triggers at the moment on every push to main branch but have out commented trigger on every pull request.

### Workflow Description:

#### 1. Check out repository

    Checking out, syncing & fetching the repository

#### 2. Start minikube

      Starting up minikube with the docker driver

#### 3. Edit host file

      This step passes but have issues. It is only working in local but but does not want to connect
      us later on port 8080(our chosen port) due to Githubs strict policy rules.
      The part that is failing is commented out in the build-and-deploy.yml file.

#### 4. Check hosts file

      Checking that the host file changes we did took place.

#### 5. Try the cluster

      Checking that the pods exist/is running by running "kubectl get pods -A"

#### 6. Setup Docker Environment

      Logging into minikube with docker environment

#### 7. Deploy to kubernetes and create service

      Starting minikube and deploying mariadb and opencart to the cluster

#### 8. List our pods

      Listing our pods we created

#### 9. Waiting for pods to be ready

      Running the check_pod.sh script to wait until the pods is ready

#### 10. List our pods again

      Listing our pods again to see that they are ready

#### 11. Double Check that the service is created

      Double checking that the services is created

#### 12. Send build logs to Discord

      Sending status and log created by the build to a Discord bot that displays
      it as a message in a chosen channel on a chosen discord server.
