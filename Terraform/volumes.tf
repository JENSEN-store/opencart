# Define Kubernetes Persistent Volume resources
resource "kubernetes_persistent_volume" "mariadb_data" {
  metadata {
    name = "mariadb-data-pv"
  }

  spec {
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "name"
            operator = "Exists"
          }
        }
      }
    }
    capacity = {
      storage = "5Gi"
    }

    access_modes = ["ReadWriteMany"]

    persistent_volume_source {
      local {
        path = "/mnt/data/mariadb_data"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "opencart_data" {
  metadata {
    name = "opencart-data-pv"
  }

  spec {
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "name"
            operator = "Exists"
          }
        }
      }
    }
    capacity = {
      storage = "5Gi"
    }

    access_modes = ["ReadWriteMany"]

    persistent_volume_source {
      local {
        path = "/mnt/data/opencart_data"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "opencart_storage_data" {
  metadata {
    name = "opencart-storage-data-pv"
  }

  spec {
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "name"
            operator = "Exists"
          }
        }
      }
    }
    capacity = {
      storage = "5Gi"
    }

    access_modes = ["ReadWriteMany"]

    persistent_volume_source {
      local {
        path = "/mnt/data/opencart_storage_data"
      }
    }
  }
}

# Define Kubernetes Persistent Volume Claim resources
resource "kubernetes_persistent_volume_claim" "mariadb_data" {
  metadata {
    name = "mariadb-data-pvc"
  }

  spec {
    access_modes = ["ReadWriteMany"]
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
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "opencart_storage_data" {
  metadata {
    name = "opencart-storage-data-pvc"
  }

  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}
