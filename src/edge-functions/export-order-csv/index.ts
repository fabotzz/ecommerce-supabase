import { serve } from "https://deno.land/std@0.177.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders })
    }

    try {
        const { order_id } = await req.json()

        if (!order_id) {
            throw new Error('order_id is required')
        }

        const supabaseClient = createClient(
            Deno.env.get('SUPABASE_URL') ?? '',
            Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
        )

        // Buscar detalhes do pedido
        const { data: order, error } = await supabaseClient
            .from('vw_pedidos_detalhados')
            .select('*')
            .eq('id', order_id)
            .single()

        if (error) throw error

        // Gerar CSV
        let csv = 'Pedido ID,Status,Total,Cliente,Data\n'
        csv += `"${order.id}","${order.status}","${order.total}","${order.cliente_nome}","${order.created_at}"\n\n`
        csv += 'Itens do Pedido:\n'
        csv += 'Produto,Quantidade,Preço Unitário,Subtotal\n'

        order.itens.forEach((item: any) => {
            csv += `"${item.produto_nome}","${item.quantidade}","${item.preco_unitario}","${item.subtotal}"\n`
        })

        return new Response(csv, {
            headers: {
                ...corsHeaders,
                'Content-Type': 'text/csv',
                'Content-Disposition': `attachment; filename="pedido-${order_id}.csv"`
            },
            status: 200,
        })
    } catch (error) {
        return new Response(
            JSON.stringify({ error: error.message }),
            {
                headers: { ...corsHeaders, 'Content-Type': 'application/json' },
                status: 400,
            }
        )
    }
})