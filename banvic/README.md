# BanVic Data Warehouse & Analytics Dashboard

Este projeto trata-se de um desafio para ingressar no programa de aprendizado da Indicium (Lighthouse), apresentando uma solução completa de data warehouse construída com dbt, projetada para suportar dashboards de BI.

## Visão Geral da Arquitetura

- **Data Warehouse**: Instância PostgreSQL dockerizada para portabilidade
- **Modelagem de Dados**: dbt para transformações ELT e modelagem dimensional
- **Ferramenta de BI**: PowerBI para visualizações de dashboard

## Executando o projeto

### Pré-requisitos

- Docker e Docker Compose
- Python 3.8+

### 1. Configuração do Ambiente

```bash
# Clone o repositório
git clone https://github.com/taisthomsen/desafio_lh_indicium
cd desafio_lh_indicium

# Crie e ative o ambiente virtual
python -m venv venv
source venv/bin/activate  # No Windows: venv\Scripts\activate

# Instale as dependências
pip install -r requirements.txt
```

### 2. Iniciar o Data Warehouse

```bash
# Inicie o container PostgreSQL
docker compose up -d

# Verifique se o banco está rodando
docker ps
```

### 3. Executar o dbt

```bash
cd banvic

# Instalar pacotes dbt
dbt deps

# Carregar dados de referência (taxas de câmbio)
dbt seed

# Executar todos os modelos
dbt run

# Executar testes de qualidade de dados
dbt test

# Gerar documentação
dbt docs generate
dbt docs serve
```

### 4. Conectar PowerBI

1. Abra o PowerBI Desktop
2. Conecte ao PostgreSQL:
   - Servidor: localhost
   - Porta: 55432
   - Database: banvic
   - Usuário: banvic_root
   - Senha: secure_password
3. Selecione as tabelas de dimensão e fato para seu dashboard

## 🛠️ Solução de Problemas

### Problemas de Conexão com Banco de Dados

```bash
# Verificar se PostgreSQL está rodando
docker ps | grep postgres

# Visualizar logs do banco
docker compose logs db

# Reiniciar banco de dados
docker compose restart db
```

### Problemas com dbt

```bash
# Verificar conexão dbt
dbt debug

# Limpar e reconstruir
dbt clean
dbt deps
dbt run
```

## 📚 Recursos Adicionais

- [Documentação dbt](https://docs.getdbt.com/)
- [Documentação PowerBI](https://docs.microsoft.com/pt-br/power-bi/)
