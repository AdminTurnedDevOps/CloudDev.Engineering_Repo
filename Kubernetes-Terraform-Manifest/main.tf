provider "kubernetes" {
}

resource "kubernetes_deployment" "gocontainer" {
  metadata {
    name = "go-container"
    labels = {
      environment = "development"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        environment = "development"
      }
    }

    template {
      metadata {
        labels = {
         environment = "development"
        }
      }

      spec {
        container {
          image = "golang:latest"
          name  = "goapp"

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}