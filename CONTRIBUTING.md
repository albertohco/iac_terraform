# Contribuindo para o Projeto

## 🎯 Código de Conduta

Todos os colaboradores devem seguir nosso código de conduta baseado em respeito e profissionalismo.

## 🚀 Como Contribuir

### 1. Faça um Fork do Repositório

```bash
git clone https://github.com/albertohco/iac_terraform.git
cd iac_terraform
```

### 2. Crie uma Branch para sua Feature

```bash
git checkout -b feature/minha-feature
# ou
git checkout -b fix/meu-bug
```

**Padrão de nomes**:
- `feature/` - Nova funcionalidade
- `fix/` - Correção de bug
- `docs/` - Documentação
- `refactor/` - Refatoração
- `test/` - Testes

### 3. Faça suas Mudanças

```bash
# Editar arquivos
nano main.tf

# Validar Terraform
terraform fmt
terraform validate
```

### 4. Commit suas Mudanças

```bash
git add .
git commit -m "Descrição clara da mudança"
```

**Padrão de commits**:
- ✨ `feat:` Nova funcionalidade
- 🐛 `fix:` Correção de bug
- 📝 `docs:` Documentação
- 🎨 `style:` Formatação/estilos
- ♻️ `refactor:` Refatoração
- ✅ `test:` Testes
- 🔧 `chore:` Configuração

### 5. Push para sua Branch

```bash
git push origin feature/minha-feature
```

### 6. Abra um Pull Request

1. Vá para o repositório no GitHub
2. Clique em "New Pull Request"
3. Preencha a descrição da PR
4. Aguarde a review

## 📋 Checklist para PR

Antes de submeter sua PR, verifique:

- [ ] Código está formatado com `terraform fmt`
- [ ] Validação passou com `terraform validate`
- [ ] Arquivo `terraform.tfvars` NÃO foi commitado
- [ ] Documentação foi atualizada
- [ ] Não há conflitos com a branch `main`
- [ ] CI/CD pipeline passou

## 🔍 Padrões de Código

### Terraform Style Guide

```hcl
# ✅ BOM
resource "digitalocean_vpc" "main" {
  name     = "vpc-production"
  region   = var.region
  ip_range = "10.0.0.0/24"

  tags = ["production", "managed-by-terraform"]
}

# ❌ RUIM
resource "digitalocean_vpc" "main"{
name="vpc-production"
region=var.region
ip_range="10.0.0.0/24"
}
```

### Nomes de Recursos

```hcl
# ✅ BOM
resource "digitalocean_kubernetes_cluster" "main"
resource "digitalocean_database_cluster" "postgres_production"

# ❌ RUIM
resource "digitalocean_kubernetes_cluster" "k8s_main_cluster_prod_1"
resource "digitalocean_database_cluster" "db"
```

### Variáveis

```hcl
# ✅ BOM
variable "region" {
  description = "Região DigitalOcean"
  type        = string
  default     = "nyc1"
}

# ❌ RUIM
variable "r" {
  type = string
}
```

## 📚 Documentação

Ao adicionar novo recurso, atualize:

1. **README.md** - Descrição do recurso
2. **QUICKSTART.md** - Exemplo de uso
3. **variables.tf** - Documentação das variáveis
4. **outputs.tf** - Saídas exportadas

### Exemplo de Documentação

```markdown
### Novo Recurso: XYZ

- **Nome**: `xyz`
- **Descrição**: O que faz
- **Variáveis**:
  - `xyz_name`: Nome do recurso (padrão: "xyz-1")
  - `xyz_size`: Tamanho (padrão: "s-1vcpu-1gb")
- **Outputs**: endpoints, IDs, etc.

Uso:
\`\`\`bash
terraform apply -var="xyz_name=meu-xyz"
\`\`\`
```

## 🧪 Testando Localmente

Antes de fazer PR, teste localmente:

```bash
# Inicializar
terraform init

# Validar sintaxe
terraform validate

# Formatar código
terraform fmt -recursive

# Planejar (sem aplicar!)
terraform plan -var-file=terraform.tfvars

# Se tudo OK, fazer commit
```

## 🚫 O que NÃO fazer

- ❌ Commit `terraform.tfvars` ou tokens
- ❌ Modificar CI/CD sem discussion
- ❌ Aumentar drasticamente a escala de recursos sem aviso
- ❌ Remover recursos críticos sem discussão
- ❌ Usar hardcoding em vez de variáveis
- ❌ Cometer estado do Terraform (`.tfstate`)

## 📞 Suporte e Discussões

- **Issues**: Reportar bugs e solicitar features
- **Discussions**: Compartilhar ideias e melhorias
- **PR Reviews**: Feedback construtivo

## 📖 Recursos Úteis

- [Terraform Best Practices](https://www.terraform.io/docs/language/style)
- [DigitalOcean Terraform Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/)

## 🎉 Agradecimentos

Obrigado por contribuir! Suas contribuições tornam este projeto melhor para todos.

---

**Última atualização**: Novembro 2025
