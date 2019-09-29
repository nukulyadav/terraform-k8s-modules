resource "k8s_config_istio_io_v1alpha2_metric" "requestsize" {
  metadata {
    labels = {
      "app"      = "mixer"
      "chart"    = "mixer"
      "heritage" = "Tiller"
      "release"  = "istio"
    }
    name      = "requestsize"
    namespace = "${var.namespace}"
  }
  spec = <<-JSON
    {
      "dimensions": {
        "connection_security_policy": "conditional((context.reporter.kind | \"inbound\") == \"outbound\", \"unknown\", conditional(connection.mtls | false, \"mutual_tls\", \"none\"))",
        "destination_app": "destination.labels[\"app\"] | \"unknown\"",
        "destination_principal": "destination.principal | \"unknown\"",
        "destination_service": "destination.service.host | \"unknown\"",
        "destination_service_name": "destination.service.name | \"unknown\"",
        "destination_service_namespace": "destination.service.namespace | \"unknown\"",
        "destination_version": "destination.labels[\"version\"] | \"unknown\"",
        "destination_workload": "destination.workload.name | \"unknown\"",
        "destination_workload_namespace": "destination.workload.namespace | \"unknown\"",
        "permissive_response_code": "rbac.permissive.response_code | \"none\"",
        "permissive_response_policyid": "rbac.permissive.effective_policy_id | \"none\"",
        "reporter": "conditional((context.reporter.kind | \"inbound\") == \"outbound\", \"source\", \"destination\")",
        "request_protocol": "api.protocol | context.protocol | \"unknown\"",
        "response_code": "response.code | 200",
        "response_flags": "context.proxy_error_code | \"-\"",
        "source_app": "source.labels[\"app\"] | \"unknown\"",
        "source_principal": "source.principal | \"unknown\"",
        "source_version": "source.labels[\"version\"] | \"unknown\"",
        "source_workload": "source.workload.name | \"unknown\"",
        "source_workload_namespace": "source.workload.namespace | \"unknown\""
      },
      "monitored_resource_type": "\"UNSPECIFIED\"",
      "value": "request.size | 0"
    }
    JSON
}