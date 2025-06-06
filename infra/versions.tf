terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  sensitive = true
  type      = string
}

provider "digitalocean" {
  token = var.do_token
}

# provider "kubernetes" {
#   host  = data.digitalocean_kubernetes_cluster.example.endpoint
#   token = data.digitalocean_kubernetes_cluster.example.kube_config[0].token
#   cluster_ca_certificate = base64decode(
#     data.digitalocean_kubernetes_cluster.example.kube_config[0].cluster_ca_certificate
#   )
# }

# provider "helm" {

# }
