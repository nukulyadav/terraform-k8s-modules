terraform {
  required_providers {
    k8s = {
      source  = "mingfang/k8s"
    }
  }
}

locals {
  labels = lookup(var.parameters, "labels", {
    app     = var.parameters.name
    name    = var.parameters.name
    service = var.parameters.name
  })

  selector = {
    match_labels = local.labels
  }

  podAnnotations = merge(coalesce(lookup(var.parameters, "annotations", {}), {}), var.podAnnotations)

  k8s_core_v1_service_parameters = merge(
    var.parameters,
    { labels = local.labels, selector = local.labels },
  )

  k8s_apps_v1_stateful_set_parameters = merge(
    var.parameters,
    { labels = local.labels, selector = local.selector, annotations = local.podAnnotations, service_name = var.parameters.name },
  )

  enable_service = length(lookup(var.parameters, "ports", [])) > 0
}
