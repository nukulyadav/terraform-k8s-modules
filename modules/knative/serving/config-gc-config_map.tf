resource "k8s_core_v1_config_map" "config-gc" {
  data = {
    "_example" = <<-EOF
      ################################
      #                              #
      #    EXAMPLE CONFIGURATION     #
      #                              #
      ################################
      
      # This block is not actually functional configuration,
      # but serves to illustrate the available configuration
      # options and document them in a way that is accessible
      # to users that `kubectl edit` this config map.
      #
      # These sample configuration options may be copied out of
      # this block and unindented to actually change the configuration.
      
      # Delay after revision creation before considering it for GC
      stale-revision-create-delay: "24h"
      
      # Duration since a route has been pointed at a revision before it should be GC'd
      # This minus lastpinned-debounce be longer than the controller resync period (10 hours)
      stale-revision-timeout: "15h"
      
      # Minimum number of generations of revisions to keep before considering for GC
      stale-revision-minimum-generations: "1"
      
      # To avoid constant updates, we allow an existing annotation to be stale by this
      # amount before we update the timestamp
      stale-revision-lastpinned-debounce: "5h"
      
      EOF
  }
  metadata {
    labels = {
      "serving.knative.dev/release" = "devel"
    }
    name = "config-gc"
    namespace = "${var.namespace}"
  }
}