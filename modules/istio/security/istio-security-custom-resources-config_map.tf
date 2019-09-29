resource "k8s_core_v1_config_map" "istio-security-custom-resources" {
  data = {
    "custom-resources.yaml" = <<-EOF
      # Authentication policy to enable permissive mode for all services (that have sidecar) in the mesh.
      apiVersion: "authentication.istio.io/v1alpha1"
      kind: "MeshPolicy"
      metadata:
        name: "default"
        labels:
          app: security
          chart: security
          heritage: Tiller
          release: istio
      spec:
        peers:
        - mtls:
            mode: PERMISSIVE	
      EOF
    "run.sh" = <<-EOF
      #!/bin/sh
      
      set -x
      
      if [ "$#" -ne "1" ]; then
          echo "first argument should be path to custom resource yaml"
          exit 1
      fi
      
      pathToResourceYAML=$${1}
      
      kubectl get validatingwebhookconfiguration istio-galley 2>/dev/null
      if [ "$?" -eq 0 ]; then
          echo "istio-galley validatingwebhookconfiguration found - waiting for istio-galley deployment to be ready"
          while true; do
              kubectl -n ${var.namespace} get deployment istio-galley 2>/dev/null
              if [ "$?" -eq 0 ]; then
                  break
              fi
              sleep 1
          done
          kubectl -n ${var.namespace} rollout status deployment istio-galley
          if [ "$?" -ne 0 ]; then
              echo "istio-galley deployment rollout status check failed"
              exit 1
          fi
          echo "istio-galley deployment ready for configuration validation"
      fi
      sleep 5
      kubectl apply -f $${pathToResourceYAML}
      EOF
  }
  metadata {
    labels = {
      "app"      = "security"
      "chart"    = "security"
      "heritage" = "Tiller"
      "istio"    = "citadel"
      "release"  = "istio"
    }
    name      = "istio-security-custom-resources"
    namespace = "${var.namespace}"
  }
}