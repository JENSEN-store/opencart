# Define Kubernetes Persistent Volume resources
resource "kubernetes_persistent_volume" "mariadb_data" {
  metadata {
    name = "mariadb-data-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      path = "/path/to/minikube-hostpath/mariadb_data"  # Update with your desired host path
    }
  }
}

resource "kubernetes_persistent_volume" "opencart_data" {
  metadata {
    name = "opencart-data-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      path = "/path/to/minikube-hostpath/opencart_data"  # Update with your desired host path
    }
  }
}

resource "kubernetes_persistent_volume" "opencart_storage_data" {
  metadata {
    name = "opencart-storage-data-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      path = "/path/to/minikube-hostpath/opencart_storage_data"  # Update with your desired host path
    }
  }
}

# Define Kubernetes Persistent Volume Claim resources
resource "kubernetes_persistent_volume_claim" "mariadb_data" {
  metadata {
    name = "mariadb-data-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "opencart_data" {
  metadata {
    name = "opencart-data-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "opencart_storage_data" {
  metadata {
    name = "opencart-storage-data-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

# Define Kubernetes Deployment resources
resource "kubernetes_deployment" "mariadb" {
  metadata {
    name = "mariadb"
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
            name       = "mariadb-data"
            mount_path = "/bitnami/mariadb"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "opencart" {
  metadata {
    name = "opencart"
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
          image = "docker.io/bitnami/opencart:4"

          port {
            container_port = 8080
          }

          port {
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
            name       = "opencart-data"
            mount_path = "/bitnami/opencart"
          }

          volume_mount {
            name       = "opencart-storage-data"
            mount_path = "/bitnami/opencart_storage/"
          }
        }
      }
    }
  }
}

# Define Kubernetes Service resources
resource "kubernetes_service" "mariadb" {
  metadata {
    name = "mariadb"
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

resource "kubernetes_service" "opencart" {
  metadata {
    name = "opencart"
  }

  spec {
    type = "LoadBalancer"
    selector = {
      app = "opencart"
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 8080
    }

    port {
      protocol = "TCP"
      port     = 443
      target_port = 8443
    }
  }
}
