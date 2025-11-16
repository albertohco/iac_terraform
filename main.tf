terraform {
  required_version = ">=1.0.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.69.0"
    }
  }
  backend "pg" {}
}


provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_vpc" "vpc" {
  name     = var.vpc_name
  region   = var.region
  ip_range = var.vpc_ip_range
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name     = var.kubernetes_cluster_name
  region   = var.region
  version  = var.kubernetes_version
  vpc_uuid = digitalocean_vpc.vpc.id

  node_pool {
    name       = var.node_pool_name
    size       = var.node_pool_size
    node_count = var.node_count
  }
}

resource "digitalocean_database_cluster" "postgres-production" {
  name       = var.postgres_cluster_name
  engine     = "pg"
  version    = var.postgres_version
  size       = var.postgres_size
  region     = var.region
  node_count = var.postgres_node_count
}

resource "local_file" "kubeconfig" {
  content  = digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config
  filename = "kubeconfig.yaml"
}
