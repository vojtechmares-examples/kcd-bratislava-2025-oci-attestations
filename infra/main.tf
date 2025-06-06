resource "digitalocean_kubernetes_cluster" "kcd_demo" {
  name   = "kcd-demo"
  region = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions` (e.g. "1.14.6-do.1"
  # If set to "latest", latest published version will be used.
  version = "latest"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 2

    taint {
      key    = "workloadKind"
      value  = "database"
      effect = "NoSchedule"
    }
  }
}
