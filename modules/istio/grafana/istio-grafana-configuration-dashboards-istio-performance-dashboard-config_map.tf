resource "k8s_core_v1_config_map" "istio-grafana-configuration-dashboards-istio-performance-dashboard" {
  data = {
    "istio-performance-dashboard.json" = <<-EOF
      { "__inputs": [ { "name": "DS_PROMETHEUS", "label": "Prometheus", "description": "", "type": "datasource", "pluginId": "prometheus", "pluginName": "Prometheus" } ], "__requires": [ { "type": "grafana", "id": "grafana", "name": "Grafana", "version": "5.2.3" }, { "type": "panel", "id": "graph", "name": "Graph", "version": "5.0.0" }, { "type": "datasource", "id": "prometheus", "name": "Prometheus", "version": "5.0.0" }, { "type": "panel", "id": "text", "name": "Text", "version": "5.0.0" } ], "annotations": { "list": [ { "builtIn": 1, "datasource": "-- Grafana --", "enable": true, "hide": true, "iconColor": "rgba(0, 211, 255, 1)", "name": "Annotations & Alerts", "type": "dashboard" } ] }, "editable": false, "gnetId": null, "graphTooltip": 0, "id": null, "links": [], "panels": [ { "aliasColors": {}, "bars": false, "dashLength": 10, "dashes": false, "datasource": "Prometheus", "fill": 1, "gridPos": { "h": 9, "w": 12, "x": 0, "y": 0 }, "id": 2, "legend": { "avg": false, "current": false, "max": false, "min": false, "show": true, "total": false, "values": false }, "lines": true, "linewidth": 1, "links": [], "nullPointMode": "null", "percentage": false, "pointradius": 5, "points": false, "renderer": "flot", "seriesOverrides": [], "spaceLength": 10, "stack": false, "steppedLine": false, "targets": [ { "expr": "(sum(rate(container_cpu_usage_seconds_total{pod_name=~\"istio-telemetry-.*\",container_name=~\"mixer|istio-proxy\"}[1m]))/ (round(sum(irate(istio_requests_total[1m])), 0.001)/1000))/ (sum(irate(istio_requests_total{source_workload=\"istio-ingressgateway\"}[1m])) >bool 10)", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-telemetry", "refId": "A" }, { "expr": "sum(rate(container_cpu_usage_seconds_total{pod_name=~\"istio-ingressgateway-.*\",container_name=\"istio-proxy\"}[1m])) / (round(sum(irate(istio_requests_total{source_workload=\"istio-ingressgateway\", reporter=\"source\"}[1m])), 0.001)/1000)", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-ingressgateway", "refId": "B" }, { "expr": "(sum(rate(container_cpu_usage_seconds_total{namespace!=\"${var.namespace}\",container_name=\"istio-proxy\"}[1m]))/ (round(sum(irate(istio_requests_total[1m])), 0.001)/1000))/ (sum(irate(istio_requests_total{source_workload=\"istio-ingressgateway\"}[1m])) >bool 10)", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-proxy", "refId": "C" }, { "expr": "(sum(rate(container_cpu_usage_seconds_total{pod_name=~\"istio-policy-.*\",container_name=~\"mixer|istio-proxy\"}[1m]))/ (round(sum(irate(istio_requests_total[1m])), 0.001)/1000)) / (sum(irate(istio_requests_total{source_workload=\"istio-ingressgateway\"}[1m])) >bool 10)", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-policy", "refId": "D" } ], "thresholds": [], "timeFrom": null, "timeShift": null, "title": "vCPU / 1k rps", "tooltip": { "shared": true, "sort": 0, "value_type": "individual" }, "type": "graph", "xaxis": { "buckets": null, "mode": "time", "name": null, "show": true, "values": [] }, "yaxes": [ { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": true }, { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": true } ], "yaxis": { "align": false, "alignLevel": null } }, { "aliasColors": {}, "bars": false, "dashLength": 10, "dashes": false, "datasource": "Prometheus", "fill": 1, "gridPos": { "h": 9, "w": 12, "x": 12, "y": 0 }, "id": 6, "legend": { "avg": false, "current": false, "max": false, "min": false, "show": true, "total": false, "values": false }, "lines": true, "linewidth": 1, "links": [], "nullPointMode": "null", "percentage": false, "pointradius": 5, "points": false, "renderer": "flot", "seriesOverrides": [], "spaceLength": 10, "stack": false, "steppedLine": false, "targets": [ { "expr": "sum(rate(container_cpu_usage_seconds_total{pod_name=~\"istio-telemetry-.*\",container_name=~\"mixer|istio-proxy\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-telemetry", "refId": "A" }, { "expr": "sum(rate(container_cpu_usage_seconds_total{pod_name=~\"istio-ingressgateway-.*\",container_name=\"istio-proxy\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-ingressgateway", "refId": "B" }, { "expr": "sum(rate(container_cpu_usage_seconds_total{namespace!=\"${var.namespace}\",container_name=\"istio-proxy\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-proxy", "refId": "C" }, { "expr": "sum(rate(container_cpu_usage_seconds_total{pod_name=~\"istio-policy-.*\",container_name=~\"mixer|istio-proxy\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-policy", "refId": "D" } ], "thresholds": [], "timeFrom": null, "timeShift": null, "title": "vCPU", "tooltip": { "shared": true, "sort": 0, "value_type": "individual" }, "type": "graph", "xaxis": { "buckets": null, "mode": "time", "name": null, "show": true, "values": [] }, "yaxes": [ { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": true }, { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": true } ], "yaxis": { "align": false, "alignLevel": null } }, { "aliasColors": {}, "bars": false, "dashLength": 10, "dashes": false, "datasource": "Prometheus", "fill": 1, "gridPos": { "h": 9, "w": 12, "x": 0, "y": 9 }, "id": 4, "legend": { "avg": false, "current": false, "max": false, "min": false, "show": true, "total": false, "values": false }, "lines": true, "linewidth": 1, "links": [], "nullPointMode": "null", "percentage": false, "pointradius": 5, "points": false, "renderer": "flot", "seriesOverrides": [], "spaceLength": 10, "stack": false, "steppedLine": false, "targets": [ { "expr": "(sum(container_memory_usage_bytes{pod_name=~\"istio-telemetry-.*\"}) / (sum(irate(istio_requests_total[1m])) / 1000)) / (sum(irate(istio_requests_total{source_workload=\"istio-ingressgateway\"}[1m])) >bool 10)", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-telemetry / 1k rps", "refId": "A" }, { "expr": "sum(container_memory_usage_bytes{pod_name=~\"istio-ingressgateway-.*\"}) / count(container_memory_usage_bytes{pod_name=~\"istio-ingressgateway-.*\",container_name!=\"POD\"})", "format": "time_series", "intervalFactor": 1, "legendFormat": "per istio-ingressgateway", "refId": "C" }, { "expr": "sum(container_memory_usage_bytes{namespace!=\"${var.namespace}\",container_name=\"istio-proxy\"}) / count(container_memory_usage_bytes{namespace!=\"${var.namespace}\",container_name=\"istio-proxy\"})", "format": "time_series", "intervalFactor": 1, "legendFormat": "per istio-proxy", "refId": "B" }, { "expr": "(sum(container_memory_usage_bytes{pod_name=~\"istio-policy-.*\"}) / (sum(irate(istio_requests_total[1m])) / 1000))/ (sum(irate(istio_requests_total{source_workload=\"istio-ingressgateway\"}[1m])) >bool 10)", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-policy / 1k rps", "refId": "D" } ], "thresholds": [], "timeFrom": null, "timeShift": null, "title": "Memory", "tooltip": { "shared": true, "sort": 0, "value_type": "individual" }, "type": "graph", "xaxis": { "buckets": null, "mode": "time", "name": null, "show": true, "values": [] }, "yaxes": [ { "format": "decbytes", "label": null, "logBase": 1, "max": null, "min": null, "show": true }, { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": true } ], "yaxis": { "align": false, "alignLevel": null } }, { "aliasColors": {}, "bars": false, "dashLength": 10, "dashes": false, "datasource": "Prometheus", "fill": 1, "gridPos": { "h": 9, "w": 12, "x": 12, "y": 9 }, "id": 5, "legend": { "avg": false, "current": false, "max": false, "min": false, "show": true, "total": false, "values": false }, "lines": true, "linewidth": 1, "links": [], "nullPointMode": "null", "percentage": false, "pointradius": 5, "points": false, "renderer": "flot", "seriesOverrides": [], "spaceLength": 10, "stack": false, "steppedLine": false, "targets": [ { "expr": "sum(irate(istio_response_bytes_sum{destination_workload=\"istio-telemetry\"}[1m])) + sum(irate(istio_request_bytes_sum{destination_workload=\"istio-telemetry\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-telemetry", "refId": "A" }, { "expr": "sum(irate(istio_response_bytes_sum{source_workload=\"istio-ingressgateway\", reporter=\"source\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-ingressgateway", "refId": "C" }, { "expr": "sum(irate(istio_response_bytes_sum{source_workload_namespace!=\"${var.namespace}\", reporter=\"source\"}[1m])) + sum(irate(istio_response_bytes_sum{destination_workload_namespace!=\"${var.namespace}\", reporter=\"destination\"}[1m])) + sum(irate(istio_request_bytes_sum{source_workload_namespace!=\"${var.namespace}\", reporter=\"source\"}[1m])) + sum(irate(istio_request_bytes_sum{destination_workload_namespace!=\"${var.namespace}\", reporter=\"destination\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-proxy", "refId": "D" }, { "expr": "sum(irate(istio_response_bytes_sum{destination_workload=\"istio-policy\"}[1m])) + sum(irate(istio_request_bytes_sum{destination_workload=\"istio-policy\"}[1m]))", "format": "time_series", "intervalFactor": 1, "legendFormat": "istio-policy", "refId": "E" } ], "thresholds": [], "timeFrom": null, "timeShift": null, "title": "Bytes transferred / sec", "tooltip": { "shared": true, "sort": 0, "value_type": "individual" }, "type": "graph", "xaxis": { "buckets": null, "mode": "time", "name": null, "show": true, "values": [] }, "yaxes": [ { "format": "bytes", "label": null, "logBase": 1, "max": null, "min": null, "show": true }, { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": true } ], "yaxis": { "align": false, "alignLevel": null } }, { "aliasColors": {}, "bars": false, "dashLength": 10, "dashes": false, "datasource": "Prometheus", "fill": 1, "gridPos": { "h": 9, "w": 24, "x": 0, "y": 18 }, "id": 8, "legend": { "alignAsTable": false, "avg": false, "current": false, "max": false, "min": false, "rightSide": false, "show": true, "total": false, "values": false }, "lines": true, "linewidth": 1, "links": [], "nullPointMode": "null", "percentage": false, "pointradius": 5, "points": false, "renderer": "flot", "seriesOverrides": [], "spaceLength": 10, "stack": false, "steppedLine": false, "targets": [ { "expr": "sum(istio_build) by (component, tag)", "format": "time_series", "intervalFactor": 1, "legendFormat": "{{ component }}: {{ tag }}", "refId": "A" } ], "thresholds": [], "timeFrom": null, "timeShift": null, "title": "Istio Components by Version", "tooltip": { "shared": true, "sort": 0, "value_type": "individual" }, "transparent": false, "type": "graph", "xaxis": { "buckets": null, "mode": "time", "name": null, "show": true, "values": [] }, "yaxes": [ { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": true }, { "format": "short", "label": null, "logBase": 1, "max": null, "min": null, "show": false } ], "yaxis": { "align": false, "alignLevel": null } }, { "content": "The charts on this dashboard are intended to show Istio main components cost in terms resources utilization under steady load.\n\n- **vCPU/1k rps:** shows vCPU utilization by the main Istio components normalized by 1000 requests/second. When idle or low traffic, this chart will be blank. The curve for istio-proxy refers to the services sidecars only. \n- **vCPU:** vCPU utilization by Istio components, not normalized.\n- **Memory:** memory footprint for the components. Telemetry and policy are normalized by 1k rps, and no data is shown  when there is no traffic. For ingress and istio-proxy, the data is per instance. \n- **Bytes transferred/ sec:** shows the number of bytes flowing through each Istio component.", "gridPos": { "h": 4, "w": 24, "x": 0, "y": 18 }, "id": 11, "links": [], "mode": "markdown", "title": "Istio Performance Dashboard Readme", "type": "text" } ], "schemaVersion": 16, "style": "dark", "tags": [], "templating": { "list": [] }, "time": { "from": "now-5m", "to": "now" }, "timepicker": { "refresh_intervals": [ "5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d" ], "time_options": [ "5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d" ] }, "timezone": "", "title": "Istio Performance Dashboard", "version": 4 } 
      EOF
  }
  metadata {
    labels = {
      "app" = "grafana"
      "chart" = "grafana"
      "heritage" = "Tiller"
      "istio" = "grafana"
      "release" = "istio"
    }
    name = "istio-grafana-configuration-dashboards-istio-performance-dashboard"
    namespace = "${var.namespace}"
  }
}