# Guia Rápido - Terraform DigitalOcean

## 📦 Instalação Rápida (5 minutos)

### Passo 1: Obter Token DigitalOcean

1. Acesse https://cloud.digitalocean.com/account/api/tokens
2. Clique em "Generate New Token"
3. Copie o token gerado

### Passo 2: Configurar Credenciais

```bash
# Copiar arquivo de exemplo
cp terraform.tfvars.example terraform.tfvars

# Editar com seu token
nano terraform.tfvars
```

Edite o arquivo e adicione seu token:
```hcl
digitalocean_token = "dop_v1_seu_token_aqui"
```

### Passo 3: Deploy

```bash
# Inicializar Terraform
terraform init

# Ver o plano
terraform plan

# Aplicar
terraform apply
```

**Tempo de espera**: ~5-10 minutos para o Kubernetes ficar pronto.

## 🔑 Acessando seu Cluster

```bash
# O arquivo kubeconfig.yaml será criado automaticamente

# Configurar kubectl
export KUBECONFIG=$(pwd)/kubeconfig.yaml

# Testar acesso
kubectl get nodes

# Ver pods do sistema
kubectl get pods -A
```

## 📊 Visualizar Informações

```bash
# Ver todos os outputs
terraform output

# Ver endpoint do Kubernetes
terraform output kubernetes_endpoint

# Ver host do PostgreSQL
terraform output postgres_host
```

## 🗑️ Limpar Recursos

```bash
# ⚠️ CUIDADO: Isto deletará TODOS os recursos

terraform destroy
```

## 🔗 Links Úteis

- DigitalOcean Console: https://cloud.digitalocean.com/
- API Documentation: https://docs.digitalocean.com/reference/api/
- Kubernetes Docs: https://kubernetes.io/docs/
- Terraform Registry: https://registry.terraform.io/

## 💡 Dicas Profissionais

### Usar variáveis customizadas

```bash
# Aplicar com variáveis diferentes
terraform apply -var="region=sfo3" -var="node_count=5"
```

### Planejar antes de aplicar

```bash
# Salvar plano em arquivo
terraform plan -out=tfplan

# Revisar offline
# ... revisar tfplan ...

# Aplicar com o plano salvo
terraform apply tfplan
```

### Destruir recurso específico

```bash
terraform destroy -target=digitalocean_database_cluster.postgres-production
```

### Atualizar provider

```bash
terraform init -upgrade
```

## 🐛 Debugging

```bash
# Ativar logs detalhados
export TF_LOG=DEBUG
terraform plan

# Salvar logs em arquivo
export TF_LOG_PATH=/tmp/terraform.log
terraform apply
```

## 📝 Estrutura de Arquivos

```
iac/
├── main.tf                    # Recursos principais
├── variables.tf               # Definição de variáveis
├── outputs.tf                 # Saídas do Terraform
├── terraform.tfvars           # SEGRETO - não commitar
├── terraform.tfvars.example   # Exemplo seguro
├── kubeconfig.yaml            # Gerado automaticamente
└── README.md                  # Documentação
```

## 🆘 Problemas Comuns

### "Invalid token"

Verifique se o token está correto em `terraform.tfvars`

### "VPC range overlaps"

Mude o `vpc_ip_range` em `terraform.tfvars.example` para `10.30.0.0/24`

### Cluster levando muito tempo

É normal levar 5-10 minutos. Use `terraform state list` para confirmar que está sendo criado.

### kubeconfig.yaml não foi criado

Certifique-se de que o cluster foi criado com sucesso:
```bash
terraform state show digitalocean_kubernetes_cluster.k8s
```

---

**Precisa de ajuda?** Consulte a documentação completa em README.md
