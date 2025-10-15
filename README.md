# Ecommerce Backend - Supabase

## Descrição do Projeto
Backend completo para sistema de e-commerce desenvolvido com Supabase, implementando todas as funcionalidades requisitadas no teste técnico.

  
## Funcionalidades Implementadas

### 1. Estrutura de Banco de Dados
- Tabelas: clientes, produtos, pedidos, pedido_itens, categorias
- Relacionamentos e constraints adequados
- Timestamps automáticos para auditoria

### 2. Segurança (Row Level Security)
- Políticas para todas as tabelas
- Clientes acessam apenas seus próprios dados
- Produtos visíveis publicamente
- Relatórios restritos a usuários autenticados

### 3. Automação com Database Functions
- `calcular_total_pedido()` - Cálculo automático de totais
- `atualizar_status_pedido()` - Controle de status
- `verificar_estoque()` - Validação de disponibilidade
- Trigger para atualização automática de totais

### 4. Views Otimizadas
- `vw_pedidos_detalhados` - Dados completos do pedido
- `vw_produtos_disponiveis` - Catálogo com estoque
- `vw_relatorio_vendas` - Métricas de vendas

### 5. Edge Functions
- `send-order-confirmation` - Simulação de envio de email
- `export-order-csv` - Exportação de pedidos em CSV

## Como Executar

### Pré-requisitos
- Conta no Supabase
- Deno (para desenvolvimento local)

### Configuração
1. Criar projeto no Supabase
2. Executar scripts SQL na ordem numérica
3. Deploy das Edge Functions
4. Configurar variáveis de ambiente

### Execução dos Scripts
-- Ordem de execução no SQL Editor:
01-tables.sql → 02-rls-policies.sql → 03-functions.sql → 04-views.sql

## Exemplos de Uso

### Consulta de Pedidos
SELECT * FROM vw_pedidos_detalhados WHERE id = 'uuid';

### Uso das Edge Functions

Envio de confirmação:
curl -X POST https://[project].supabase.co/functions/v1/send-order-confirmation \
  -H "Content-Type: application/json" \
  -d '{"order_id": "uuid", "customer_email": "cliente@email.com"}'

Exportação CSV:
curl -X POST https://[project].supabase.co/functions/v1/export-order-csv \
  -H "Content-Type: application/json" \
  -d '{"order_id": "uuid"}'

## Decisões Técnicas

### Arquitetura
- Separação clara entre camadas de dados e aplicação
- SQL puro para operações de banco
- TypeScript para Edge Functions

### Segurança
- RLS ativo em todas as tabelas
- Chaves de API segregadas (public vs service role)
- Validação de entrada nas Edge Functions

### Performance
- Views materializadas para consultas frequentes
- Índices automáticos do PostgreSQL
- Queries otimizadas com JOINs adequados

## Considerações Finais

O projeto atende todos os requisitos do teste técnico, demonstrando proficiência em:
- Modelagem de banco relacional
- Implementação de segurança com RLS
- Automação com stored procedures e triggers
- Desenvolvimento de APIs com Edge Functions
- Documentação clara e código organizado

