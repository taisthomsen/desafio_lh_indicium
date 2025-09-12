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
        from {{ ref('stg_erp__contas') }}
    )

    ,agencias as (
        select *
        from {{ ref('dim_agencias') }}
    )

    ,final as (
        select
            -- Primary Key
            p.proposta_pk
            
            -- Foreign Keys
            ,c.colaborador_pk as colaborador_fk
            ,cl.cliente_pk as cliente_fk
            ,a.agencia_pk as agencia_fk
            
            -- Proposal Details
            ,p.data_entrada_proposta
            ,p.ano_proposta
            ,p.mes_proposta
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
            on p.colaborador_fk = c.colaborador_pk
        left join clientes cl 
            on p.cliente_fk = cl.cliente_pk
        left join contas co
            on cl.cliente_pk = co.cod_cliente_id
        left join agencias a 
            on co.cod_agencia_id = a.agencia_pk
    )

select *
from final
