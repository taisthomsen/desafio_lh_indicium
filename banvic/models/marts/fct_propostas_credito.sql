with
    propostas as (
        select *
        from {{ ref('int_propostas_credito') }}
    )

    ,colaboradores as (
        select *
        from {{ ref('dim_colaboradores') }}
    )

    ,clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    ,contas as (
        select *
        from {{ ref('dim_contas') }}
    )

    ,agencias as (
        select *
        from {{ ref('dim_agencias') }}
    )

    ,final as (
        select
            -- Primary Key
            p.proposta_id
            
            -- Foreign Keys
            ,c.colaborador_id 
            ,cl.cliente_id 
            ,a.agencia_id 
            
            -- Proposal Details
            ,p.data_entrada_proposta
            ,p.taxa_juros_mensal
            ,p.valor_proposta
            ,p.valor_financiamento
            ,p.valor_entrada
            ,p.valor_prestacao
            ,p.quantidade_parcelas
            ,p.carencia
            ,p.status_proposta

        from propostas p
        left join colaboradores c 
            on p.colaborador_id = c.colaborador_id
        left join clientes cl 
            on p.cliente_id = cl.cliente_id
        left join contas co
            on cl.cliente_id = co.cliente_id
        left join agencias a 
            on co.agencia_id = a.agencia_id
    )

select *
from final
