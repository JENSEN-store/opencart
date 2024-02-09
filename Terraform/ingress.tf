resource "kubernetes_ingress_v1" "opencart" {
  metadata {
    name = "opencart-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "cert-manager.io/cluster-issuer" = "lets-encrypt"
    }
  }

  spec {
    ingress_class_name = "nginx"
    default_backend {
      service {
        name = "opencart-service"
        port {
          number = 80
        }
      }
    }

    rule {
      host = "opencart.jamjarlid.com"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "opencart-service"
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
      secret_name = "letsencrypt-microk8s"
    }
  }
}