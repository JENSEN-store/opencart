resource "kubernetes_deployment" "opencart_backend" {
  metadata {
    name      = "opencart-backend"
    namespace = "opencart"
    labels = {
      test = "opencart_backend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "opencart_backend"
      }
    }

    template {
      metadata {
        labels = {
          test = "opencart_backend"
        }
      }

      spec {
        container {
          image = "docker.io/bitnami/opencart:4"
          name  = "opencart4-image"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "mariadb" {
  metadata {
    name      = "mariadb"
    namespace = "database"
    labels = {
      test = "mariadb"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "mariadb"
      }
    }

    template {
      metadata {
        labels = {
          test = "mariadb"
        }
      }

      spec {
        container {
          image = "docker.io/bitnami/mariadb:11.2"
          name  = "mariadb-image"
        }
      }
    }
  }
}

resource "kubernetes_service" "opencart_backend" {
  metadata {
    name      = "opencart-network"
    namespace = "opencart_network"
  }

  spec {
    selector = {
      app = "opencart_backend"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "mariadb" {
  metadata {
    name      = "mariadb"
    namespace = "mariadb"
  }

  spec {
    selector = {
      app = "mariadb"
    }

    port {
      protocol    = "TCP"
      port        = 3306
      target_port = 3306
    }

    type = "ClusterIP"
  }
}