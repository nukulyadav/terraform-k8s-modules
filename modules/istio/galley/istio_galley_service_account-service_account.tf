resource "k8s_core_v1_service_account" "istio_galley_service_account" {
  metadata {
    labels = {
      "app"      = "galley"
      "chart"    = "galley"
      "heritage" = "Tiller"
      "release"  = "istio"
    }
    name      = "istio-galley-service-account"
    namespace = var.namespace
  }
}