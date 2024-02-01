# Define Kubernetes Deployment resources
resource "kubernetes_deployment" "mariadb_deployment" {
  metadata {
    name = "mariadb-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mariadb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mariadb"
        }
      }

      spec {
        container {
          name  = "mariadb"
          image = "docker.io/bitnami/mariadb:11.2"

          env {
            name  = "ALLOW_EMPTY_PASSWORD"
            value = "yes"
          }

          env {
            name  = "MARIADB_USER"
            value = "bn_opencart"
          }

          env {
            name  = "MARIADB_DATABASE"
            value = "bitnami_opencart"
          }

          volume_mount {
            name       = "mariadb-data-pv"
            mount_path = "/bitnami/mariadb"
          }
        }
        volume {
          name = "mariadb-data-pv"

          persistent_volume_claim {
            claim_name = "mariadb-data-pvc"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "opencart_deployment" {
  metadata {
    name = "opencart-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "opencart"
      }
    }

    template {
      metadata {
        labels = {
          app = "opencart"
        }
      }

      spec {
        container {
          name  = "opencart"
          image = "docker.io/draginojd/jensenstore:1.0.1"

          port {
            name = "http-port"
            container_port = 8080
          }

          port {
            name = "https-port"
            container_port = 8443
          }

          env {
            name  = "OPENCART_HOST"
            value = "localhost"
          }

          env {
            name  = "OPENCART_DATABASE_HOST"
            value = "mariadb"
          }

          env {
            name  = "OPENCART_DATABASE_PORT_NUMBER"
            value = "3306"
          }

          env {
            name  = "OPENCART_DATABASE_USER"
            value = "bn_opencart"
          }

          env {
            name  = "OPENCART_DATABASE_NAME"
            value = "bitnami_opencart"
          }

          env {
            name  = "ALLOW_EMPTY_PASSWORD"
            value = "yes"
          }

          volume_mount {
            name       = "opencart-data-pv"
            mount_path = "/bitnami/opencart-pv"
          }

          volume_mount {
            name       = "opencart-storage-data-pv"
            mount_path = "/bitnami/opencart_storage/"
          }
        }
        volume {
          name = "opencart-data-pv"
          persistent_volume_claim {
            claim_name = "opencart-data-pvc"
          }
        }
        volume {
          name = "opencart-storage-data-pv"
          persistent_volume_claim {
            claim_name = "opencart-storage-data-pvc"
          }
        }
      }
    }
  }
}

# Define Kubernetes Service resources
resource "kubernetes_service" "mariadb_service" {
  metadata {
    name = "mariadb-service"
  }

  spec {
    selector = {
      app = "mariadb"
    }

    port {
      protocol = "TCP"
      port     = 3306
      target_port = 3306
    }
  }
}

resource "kubernetes_service" "opencart_service" {
  metadata {
    name = "opencart-service"
  }

  spec {
    type = "ClusterIP"
    selector = {
      app = "opencart"
    }

    port {
      name = "http-port"
      protocol = "TCP"
      port     = 80
      target_port = 80
    }

    port {
      name = "https-port"
      protocol = "TCP"
      port = 443
      target_port = 8443
    }
  }
}