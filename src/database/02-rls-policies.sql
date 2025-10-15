-- Ativar RLS em todas as tabelas
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE categorias ENABLE ROW LEVEL SECURITY;
ALTER TABLE produtos ENABLE ROW LEVEL SECURITY;
ALTER TABLE pedidos ENABLE ROW LEVEL SECURITY;
ALTER TABLE pedido_itens ENABLE ROW LEVEL SECURITY;

-- POL�TICAS PARA CLIENTES
-- Clientes podem ver/editar apenas seus pr�prios dados
CREATE POLICY "Clientes veem apenas pr�prio perfil" ON clientes
    FOR SELECT USING (auth.uid()::text = id::text);

CREATE POLICY "Clientes atualizam apenas pr�prio perfil" ON clientes
    FOR UPDATE USING (auth.uid()::text = id::text);

-- POL�TICAS PARA PRODUTOS
-- Todos podem ver produtos ativos
CREATE POLICY "Todos veem produtos ativos" ON produtos
    FOR SELECT USING (ativo = true);

-- POL�TICAS PARA PEDIDOS
-- Clientes veem apenas seus pr�prios pedidos
CREATE POLICY "Clientes veem pr�prios pedidos" ON pedidos
    FOR SELECT USING (auth.uid()::text = cliente_id::text);

CREATE POLICY "Clientes criam pr�prios pedidos" ON pedidos
    FOR INSERT WITH CHECK (auth.uid()::text = cliente_id::text);

-- POL�TICAS PARA PEDIDO_ITENS
-- Clientes veem itens apenas de seus pedidos
CREATE POLICY "Clientes veem itens de pr�prios pedidos" ON pedido_itens
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM pedidos 
            WHERE pedidos.id = pedido_itens.pedido_id 
            AND pedidos.cliente_id::text = auth.uid()::text
        )
    );

-- POL�TICAS PARA CATEGORIAS
-- Todos podem ver categorias
CREATE POLICY "Todos veem categorias" ON categorias
    FOR SELECT USING (true);