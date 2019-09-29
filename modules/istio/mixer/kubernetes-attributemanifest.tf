resource "k8s_config_istio_io_v1alpha2_attributemanifest" "kubernetes" {
  metadata {
    labels = {
      "app"      = "mixer"
      "chart"    = "mixer"
      "heritage" = "Tiller"
      "release"  = "istio"
    }
    name      = "kubernetes"
    namespace = "${var.namespace}"
  }
  spec = <<-JSON
    {
      "attributes": {
        "destination.container.name": {
          "valueType": "STRING"
        },
        "destination.ip": {
          "valueType": "IP_ADDRESS"
        },
        "destination.labels": {
          "valueType": "STRING_MAP"
        },
        "destination.metadata": {
          "valueType": "STRING_MAP"
        },
        "destination.name": {
          "valueType": "STRING"
        },
        "destination.namespace": {
          "valueType": "STRING"
        },
        "destination.owner": {
          "valueType": "STRING"
        },
        "destination.service.host": {
          "valueType": "STRING"
        },
        "destination.service.name": {
          "valueType": "STRING"
        },
        "destination.service.namespace": {
          "valueType": "STRING"
        },
        "destination.service.uid": {
          "valueType": "STRING"
        },
        "destination.serviceAccount": {
          "valueType": "STRING"
        },
        "destination.workload.name": {
          "valueType": "STRING"
        },
        "destination.workload.namespace": {
          "valueType": "STRING"
        },
        "destination.workload.uid": {
          "valueType": "STRING"
        },
        "source.ip": {
          "valueType": "IP_ADDRESS"
        },
        "source.labels": {
          "valueType": "STRING_MAP"
        },
        "source.metadata": {
          "valueType": "STRING_MAP"
        },
        "source.name": {
          "valueType": "STRING"
        },
        "source.namespace": {
          "valueType": "STRING"
        },
        "source.owner": {
          "valueType": "STRING"
        },
        "source.serviceAccount": {
          "valueType": "STRING"
        },
        "source.services": {
          "valueType": "STRING"
        },
        "source.workload.name": {
          "valueType": "STRING"
        },
        "source.workload.namespace": {
          "valueType": "STRING"
        },
        "source.workload.uid": {
          "valueType": "STRING"
        }
      }
    }
    JSON
}