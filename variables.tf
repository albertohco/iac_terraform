# Variáveis do Projeto Terraform
# Este arquivo define as variáveis utilizadas em main.tf

variable "digitalocean_token" {
  description = "Token de autenticação DigitalOcean"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Região DigitalOcean"
  type        = string
  default     = "nyc1"

  validation {
    condition     = contains(["nyc1", "nyc3", "sfo1", "sfo3", "lon1", "ams3", "fra1", "blr1", "sgp1", "syd1", "tor1"], var.region)
    error_message = "Região inválida. Use uma das regiões suportadas pelo DigitalOcean."
  }
}

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
  default     = "vpc-2"
}

variable "vpc_ip_range" {
  description = "Range de IP para a VPC"
  type        = string
  default     = "10.20.0.0/24"
}

variable "kubernetes_cluster_name" {
  description = "Nome do cluster Kubernetes"
  type        = string
  default     = "k8s-1"
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.33.1-do.5"
}

variable "node_pool_name" {
  description = "Nome do node pool"
  type        = string
  default     = "default"
}

variable "node_pool_size" {
  description = "Tamanho dos nós (SKU)"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "node_count" {
  description = "Número de nós no pool"
  type        = number
  default     = 3

  validation {
    condition     = var.node_count >= 1 && var.node_count <= 20
    error_message = "Node count deve estar entre 1 e 20."
  }
}

variable "postgres_cluster_name" {
  description = "Nome do cluster PostgreSQL"
  type        = string
  default     = "example-postgres-cluster"
}

variable "postgres_version" {
  description = "Versão do PostgreSQL"
  type        = string
  default     = "15"

  validation {
    condition     = contains(["11", "12", "13", "14", "15", "16"], var.postgres_version)
    error_message = "Versão PostgreSQL não suportada."
  }
}

variable "postgres_size" {
  description = "Tamanho do cluster PostgreSQL"
  type        = string
  default     = "db-s-1vcpu-1gb"
}

variable "postgres_node_count" {
  description = "Número de nós PostgreSQL"
  type        = number
  default     = 1

  validation {
    condition     = var.postgres_node_count >= 1 && var.postgres_node_count <= 3
    error_message = "Node count PostgreSQL deve estar entre 1 e 3."
  }
}
