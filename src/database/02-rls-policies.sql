-- Ativar RLS em todas as tabelas
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE categorias ENABLE ROW LEVEL SECURITY;
ALTER TABLE produtos ENABLE ROW LEVEL SECURITY;
ALTER TABLE pedidos ENABLE ROW LEVEL SECURITY;
ALTER TABLE pedido_itens ENABLE ROW LEVEL SECURITY;

-- POLÍTICAS PARA CLIENTES
-- Clientes podem ver/editar apenas seus próprios dados
CREATE POLICY "Clientes veem apenas próprio perfil" ON clientes
    FOR SELECT USING (auth.uid()::text = id::text);

CREATE POLICY "Clientes atualizam apenas próprio perfil" ON clientes
    FOR UPDATE USING (auth.uid()::text = id::text);

-- POLÍTICAS PARA PRODUTOS
-- Todos podem ver produtos ativos
CREATE POLICY "Todos veem produtos ativos" ON produtos
    FOR SELECT USING (ativo = true);

-- POLÍTICAS PARA PEDIDOS
-- Clientes veem apenas seus próprios pedidos
CREATE POLICY "Clientes veem próprios pedidos" ON pedidos
    FOR SELECT USING (auth.uid()::text = cliente_id::text);

CREATE POLICY "Clientes criam próprios pedidos" ON pedidos
    FOR INSERT WITH CHECK (auth.uid()::text = cliente_id::text);

-- POLÍTICAS PARA PEDIDO_ITENS
-- Clientes veem itens apenas de seus pedidos
CREATE POLICY "Clientes veem itens de próprios pedidos" ON pedido_itens
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM pedidos 
            WHERE pedidos.id = pedido_itens.pedido_id 
            AND pedidos.cliente_id::text = auth.uid()::text
        )
    );

-- POLÍTICAS PARA CATEGORIAS
-- Todos podem ver categorias
CREATE POLICY "Todos veem categorias" ON categorias
    FOR SELECT USING (true);