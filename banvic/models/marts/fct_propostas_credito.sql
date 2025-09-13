with
    propostas as (
        select *
        from {{ ref('int_propostas_credito') }}
    )

    , colaboradores as (
        select *
        from {{ ref('dim_colaboradores') }}
    )

    , clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    , contas as (
        select *
        from {{ ref('dim_contas') }}
    )

    , agencias as (
        select *
        from {{ ref('dim_agencias') }}
    )

    , final as (
        select
            p.proposta_id
            , colaboradores.colaborador_id
            , clientes.cliente_id
            , agencias.agencia_id
            , p.data_entrada_proposta
            , p.taxa_juros_mensal
            , p.valor_proposta
            , p.valor_financiamento
            , p.valor_entrada
            , p.valor_prestacao
            , p.quantidade_parcelas
            , p.carencia
            , p.status_proposta

        from propostas as p
        left join colaboradores
            on p.colaborador_id = colaboradores.colaborador_id
        left join clientes
            on p.cliente_id = clientes.cliente_id
        left join contas
            on clientes.cliente_id = contas.cliente_id
        left join agencias
            on contas.agencia_id = agencias.agencia_id
    )

select *
from final
