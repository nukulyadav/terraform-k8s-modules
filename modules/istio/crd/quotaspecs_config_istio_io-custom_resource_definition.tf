resource "k8s_apiextensions_k8s_io_v1beta1_custom_resource_definition" "quotaspecs_config_istio_io" {
  metadata {
    annotations = {
      "helm.sh/resource-policy" = "keep"
    }
    labels = {
      "app"      = "istio-mixer"
      "chart"    = "istio"
      "heritage" = "Tiller"
      "release"  = "istio"
    }
    name = "quotaspecs.config.istio.io"
  }
  spec {
    group = "config.istio.io"
    names {
      categories = [
        "istio-io",
        "apim-istio-io",
      ]
      kind     = "QuotaSpec"
      plural   = "quotaspecs"
      singular = "quotaspec"
    }
    scope   = "Namespaced"
    version = "v1alpha2"
  }
}