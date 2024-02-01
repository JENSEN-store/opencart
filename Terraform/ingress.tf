resource "kubernetes_ingress_v1" "opencart" {
  metadata {
    name = "opencart-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"

    }
  }

  spec {
    default_backend {
      service {
        name = "opencart"
        port {
          number = 80
        }
      }
    }

    rule {
      host = "opencart.jamjarlid.com"
      http {
        path {
          path = "/*"
          backend {
            service {
              name = "opencart"
              port {
                number = 80
              }
            }
          }
        }
      }
    }

    tls {
      hosts = ["opencart.jamjarlid.com"]
      secret_name = "opencart-secret"
    }
  }
}

resource "kubernetes_secret" "opencart_secret" {
  metadata {
    name = "opencart-secret"
  }
  data = {
    "tls.crt" = base64encode(file("../tls.crt"))
    "tls.key" = base64encode(file("../tls.key"))
  }
}