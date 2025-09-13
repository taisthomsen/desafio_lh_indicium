with
    transacoes as (
        select *
        from {{ ref('int_transacoes') }}
    )

    , cotacao as (
        select *
        from {{ ref('stg_erp__cotacao') }}
    )

    , contas as (
        select *
        from {{ ref('dim_contas') }}
    )

    , clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    , agencias as (
        select *
        from {{ ref('dim_agencias') }}
    )

    , joined as (
        select
            t.transacao_id
            , clientes.cliente_id
            , contas.conta_id
            , agencias.agencia_id

            , t.transacao_timestamp
            , t.data_transacao
            , t.nome_transacao
            , t.valor_transacao
            , t.valor_transacao_abs
            , t.tipo_transacao

            , cotacao.cotacao

        from transacoes as t
        left join contas
            on t.conta_id = contas.conta_id
        left join clientes
            on contas.cliente_id = clientes.cliente_id
        left join agencias
            on contas.agencia_id = agencias.agencia_id
        left join cotacao
            on t.data_transacao = cotacao.data_id

    )

select *
from joined
