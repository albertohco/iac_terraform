# Outputs úteis do Terraform
# Execute: terraform output

output "kubernetes_endpoint" {
  description = "Endpoint do cluster Kubernetes"
  value       = digitalocean_kubernetes_cluster.k8s.endpoint
  sensitive   = false
}

output "kubernetes_cluster_id" {
  description = "ID do cluster Kubernetes"
  value       = digitalocean_kubernetes_cluster.k8s.id
  sensitive   = false
}

output "postgres_host" {
  description = "Host do cluster PostgreSQL"
  value       = digitalocean_database_cluster.postgres-production.host
  sensitive   = false
}

output "postgres_port" {
  description = "Porta do PostgreSQL"
  value       = digitalocean_database_cluster.postgres-production.port
  sensitive   = false
}

output "postgres_database" {
  description = "Nome do banco de dados"
  value       = digitalocean_database_cluster.postgres-production.database
  sensitive   = false
}

output "postgres_user" {
  description = "Usuário padrão do PostgreSQL"
  value       = digitalocean_database_cluster.postgres-production.user
  sensitive   = false
}

output "vpc_id" {
  description = "ID da VPC"
  value       = digitalocean_vpc.vpc.id
  sensitive   = false
}

output "vpc_name" {
  description = "Nome da VPC"
  value       = digitalocean_vpc.vpc.name
  sensitive   = false
}

output "kubeconfig_path" {
  description = "Caminho para o arquivo kubeconfig"
  value       = local_file.kubeconfig.filename
  sensitive   = false
}
