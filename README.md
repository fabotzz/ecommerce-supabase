# Teste Técnico - Backend E-commerce com Supabase

## Descrição do Projeto
Implementação de backend para sistema de e-commerce utilizando Supabase, atendendo todos os requisitos do teste técnico para vaga de Desenvolvedor Júnior/Estagiário.

## Estrutura do Banco de Dados

### Tabelas
- clientes - Cadastro de clientes
- produtos - Catálogo de produtos  
- pedidos - Registro de pedidos
- pedido_itens - Itens dos pedidos

### Views
- vw_pedidos_detalhados - Consulta de pedidos com informações completas
- vw_produtos_mais_vendidos - Relatório de produtos mais vendidos

### Funções de Banco
- calcular_total_pedido() - Calcula total do pedido automaticamente
- atualizar_estoque_pedido() - Controla estoque ao confirmar pedidos

## Segurança - Row Level Security (RLS)

Todas as tabelas possuem políticas RLS implementadas:

- Clientes visualizam e editam apenas seus próprios dados
- Produtos são visíveis publicamente (apenas ativos)
- Pedidos e itens restritos ao cliente proprietário

## Edge Functions

### 1. send-order-confirmation
- Simula envio de email de confirmação de pedido
- Retorna JSON com detalhes completos do pedido

### 2. export-order-csv  
- Gera arquivo CSV com dados completos do pedido
- Formato pronto para download e importação

## Como Testar

### Pré-requisitos
- Dados de teste já inseridos no banco
- Edge Functions deployadas

### Teste das Functions

**send-order-confirmation:**
{
  "order_id": "22222222-2222-2222-2222-222222222222",
  "customer_email": "cliente.teste@email.com"
}

**export-order-csv:**
{
"order_id": "22222222-2222-2222-2222-222222222222"
}

## Funcionalidades Implementadas

- Criação de tabelas para clientes, produtos e pedidos
- Implementação de Row Level Security (RLS)
- Funções de banco para automação de processos
- Views para consultas eficientes
- Edge Functions para envio de email e exportação CSV

## Decisões Técnicas

- Utilização de UUID para chaves primárias
- JSONB para armazenamento de endereços
- Triggers para atualização automática de totais
- Políticas RLS granulares por tabela

## Contato
- Nome: [Fabio Souza Cizinande]
- Email: [fabiocizinande60@gmail.com]
