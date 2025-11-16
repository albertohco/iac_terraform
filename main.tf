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
  name     = "vpc-2"
  region   = var.region
  ip_range = "10.20.0.0/24"
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name     = "k8s-1"
  region   = var.region
  version  = "1.33.1-do.5"
  vpc_uuid = digitalocean_vpc.vpc.id

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

resource "digitalocean_database_cluster" "postgres-production" {
  name       = "example-postgres-cluster"
  engine     = "pg"
  version    = "15"
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1
}

resource "local_file" "kubeconfig" {
  content  = digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config
  filename = "kubeconfig.yaml"
}

variable "digitalocean_token" {}

variable "region" {
  default = "nyc1"
}
