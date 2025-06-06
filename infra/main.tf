resource "digitalocean_kubernetes_cluster" "kcd_demo" {
  name    = "kcd-demo"
  region  = "fra1"
  version = "1.32.2-do.3"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 2
  }
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.kcd_demo.kube_config[0].raw_config
  sensitive = true
}
