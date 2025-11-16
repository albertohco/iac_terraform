# Infraestrutura Terraform - DigitalOcean

Projeto Infrastructure as Code (IaC) que provisiona uma infraestrutura completa na DigitalOcean com Kubernetes, PostgreSQL e rede privada.

## 📋 Visão Geral

Este projeto utiliza Terraform para provisionar e gerenciar recursos na DigitalOcean:

- **Virtual Private Cloud (VPC)**: Rede isolada com range `10.20.0.0/24`
- **Kubernetes Cluster**: DOKS (DigitalOcean Kubernetes Service) versão 1.33.1 com 3 nós
- **PostgreSQL Database**: Banco de dados gerenciado versão 17
- **Kubeconfig**: Arquivo de configuração automático para acesso ao cluster

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────┐
│         DigitalOcean - nyc1             │
├─────────────────────────────────────────┤
│                                         │
│  ┌──────────────────────────────────┐  │
│  │   VPC (10.20.0.0/24)             │  │
│  │                                  │  │
│  │  ┌────────────────────────────┐  │  │
│  │  │  Kubernetes Cluster        │  │  │
│  │  │  - 3 nós s-2vcpu-4gb       │  │  │
│  │  │  - kube v1.33.1-do.5       │  │  │
│  │  └────────────────────────────┘  │  │
│  │                                  │  │
│  └──────────────────────────────────┘  │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │  PostgreSQL Cluster              │  │
│  │  - Versão 17                     │  │
│  │  - db-s-1vcpu-1gb                │  │
│  └──────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

## 📦 Recursos Criados

### 1. VPC (Virtual Private Cloud)
- **Nome**: `vpc-1`
- **Região**: `nyc1` (Nova York)
- **Range de IP**: `10.20.0.0/24`
- **Uso**: Rede isolada para todos os recursos

### 2. Kubernetes Cluster (DOKS)
- **Nome**: `k8s-1`
- **Versão**: `1.33.1-do.5`
- **Região**: `nyc1`
- **Node Pool**:
  - Name: `default`
  - Size: `s-2vcpu-4gb` (2 vCPU, 4GB RAM)
  - Node Count: 3
- **VPC**: Integrado com a VPC criada

### 3. PostgreSQL Database
- **Nome**: `example-postgres-cluster`
- **Engine**: PostgreSQL
- **Versão**: 17
- **Size**: `db-s-1vcpu-1gb` (1 vCPU, 1GB RAM)
- **Region**: `nyc1`
- **Nodes**: 1 (single node)

### 4. Kubeconfig
- **Arquivo**: `kubeconfig.yaml`
- **Conteúdo**: Configuração automática do kubectl
- **Uso**: Acesso ao cluster Kubernetes

## 🚀 Pré-requisitos

- [Terraform](https://www.terraform.io/) >= 1.0.0
- [DigitalOcean Account](https://www.digitalocean.com/)
- DigitalOcean API Token
- (Opcional) `kubectl` para gerenciar o cluster

## 🔧 Instalação e Uso

### 1. Configurar Variáveis

Clone o repositório e configure suas credenciais:

```bash
# Copiar arquivo de variáveis
cp terraform.tfvars.example terraform.tfvars

# Editar com seu token DigitalOcean
nano terraform.tfvars
```

**Arquivo `terraform.tfvars`**:
```hcl
digitalocean_token = "dop_v1_seu_token_aqui"
```

### 2. Inicializar Terraform

```bash
terraform init
```

Este comando:
- Baixa os provedores necessários (DigitalOcean, Local)
- Configura o backend de estado (PostgreSQL remoto)
- Prepara o diretório para deploy

### 3. Planejar Infraestrutura

```bash
terraform plan
```

Revise o plano para garantir que todos os recursos serão criados corretamente.

### 4. Aplicar Configuração

```bash
terraform apply
```

Confirme a criação dos recursos digitando `yes`.

**Tempo esperado**: ~5-10 minutos para criação completa do cluster Kubernetes.

### 5. Obter Kubeconfig

Após a aplicação bem-sucedida:

```bash
# O arquivo kubeconfig.yaml será criado automaticamente
cat kubeconfig.yaml

# Configurar kubectl
export KUBECONFIG=$(pwd)/kubeconfig.yaml

# Testar acesso
kubectl get nodes
```

## 📝 Estrutura do Projeto

```
iac/
├── main.tf                    # Definição dos recursos
├── terraform.tfvars           # Variáveis de ambiente (gitignored)
├── terraform.tfvars.example   # Exemplo de variáveis
├── .github/
│   └── workflows/
│       └── main.yml           # Pipeline CI/CD GitHub Actions
├── .gitignore                 # Arquivos ignorados pelo Git
└── README.md                  # Este arquivo
```

## 🔐 Variáveis Terraform

### Variáveis Obrigatórias

| Variável | Tipo | Descrição |
|----------|------|-----------|
| `digitalocean_token` | `string` | Token de autenticação DigitalOcean |

### Variáveis Opcionais

| Variável | Tipo | Padrão | Descrição |
|----------|------|--------|-----------|
| `region` | `string` | `nyc1` | Região DigitalOcean |

## 🤖 CI/CD - GitHub Actions

O projeto inclui um workflow GitHub Actions que:

1. **Trigger**: Executa em push para a branch `main`
2. **Setup**: Instala Terraform
3. **Init**: Inicializa o backend remoto
4. **Apply**: Aplica as mudanças automaticamente

### Configuração de Secrets

Para usar o CI/CD, configure os seguintes secrets no GitHub:

```
DIGITAL_OCEAN_TOKEN       # Token de autenticação DigitalOcean
STATE_CONNECTION_STRING   # String de conexão PostgreSQL para estado remoto
```

### Arquivo de Configuração

Localizado em: `.github/workflows/main.yml`

```yaml
name: Terraform Deployment
on:
  push:
    branches:
      - main
```

## 💾 Estado Remoto

O projeto está configurado para usar PostgreSQL como backend remoto:

```hcl
backend "pg" {}
```

### Configurar Backend

```bash
terraform init -backend-config="conn_str=postgresql://user:password@host/dbname"
```

## 🛠️ Comandos Úteis

```bash
# Ver plano sem aplicar
terraform plan

# Aplicar com aprovação automática
terraform apply -auto-approve

# Destruir todos os recursos
terraform destroy

# Ver estado atual
terraform show

# Listar recursos
terraform state list

# Ver detalhes de um recurso
terraform state show digitalocean_kubernetes_cluster.k8s

# Validar sintaxe
terraform validate

# Formatar arquivo
terraform fmt
```

## 📊 Outputs

Após `terraform apply`, você pode visualizar:

```bash
# Obter informações do cluster
terraform output -raw kubernetes_endpoint

# Ver todas as saídas
terraform output
```

## 🔍 Troubleshooting

### Erro: "VPC range overlaps"

Se receber erro sobre sobreposição de range de IP:

```
This range/size overlaps with the range 10.10.0.0/16
```

**Solução**: Altere o `ip_range` em `main.tf` para uma faixa diferente, como `10.20.0.0/24`.

### Erro: "Invalid characters in VPC name"

O DigitalOcean não aceita underscores em nomes. Use hífens:

```hcl
# ❌ Incorreto
name = "vpc_1"

# ✅ Correto
name = "vpc-1"
```

### Tempo de criação do cluster

A criação do Kubernetes pode levar 5-10 minutos. Seja paciente e não interrompa o processo.

## 🔐 Segurança

- **Token**: Nunca commit o arquivo `terraform.tfvars`
- **State**: O estado é armazenado em PostgreSQL remoto
- **Backend**: Use conexão segura (SSL/TLS) para PostgreSQL
- **.gitignore**: Certifique-se de que `terraform.tfvars` está no `.gitignore`

## 📚 Recursos Adicionais

- [Documentação Terraform](https://www.terraform.io/docs)
- [Provider DigitalOcean](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
- [DigitalOcean DOKS](https://docs.digitalocean.com/products/kubernetes/)
- [Kubectl Documentation](https://kubernetes.io/docs/reference/kubectl/)

## 👥 Contribuição

1. Faça um fork do repositório
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

## 📞 Suporte

Para dúvidas ou problemas:

1. Verifique a documentação do Terraform
2. Consulte os logs do DigitalOcean
3. Abra uma issue no repositório GitHub

---

**Última atualização**: Novembro 2025
**Versão Terraform**: >= 1.0.0
**Versão Provider**: DigitalOcean 2.69.0
