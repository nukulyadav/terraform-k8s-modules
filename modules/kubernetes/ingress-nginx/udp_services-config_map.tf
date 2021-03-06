resource "k8s_core_v1_config_map" "udp_services" {
  metadata {
    labels = {
      "app.kubernetes.io/name"    = var.name
      "app.kubernetes.io/part-of" = var.name
    }
    name      = "${var.name}-udp-services"
    namespace = var.namespace
  }
}