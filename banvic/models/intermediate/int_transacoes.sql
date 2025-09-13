with

    transacoes as (
        select *
        from {{ ref('stg_erp__transacoes') }}
    )

    , transformed as (
        select
            transacao_id
            , conta_id
            , transacao_timestamp
            , cast(transacao_timestamp as date) as data_transacao
            , nome_transacao
            , valor_transacao
            , abs(valor_transacao) as valor_transacao_abs
            , case
                when valor_transacao > 0 then 'Entrada'
                when valor_transacao < 0 then 'Saida'
                else 'Neutro'
            end as tipo_transacao

        from transacoes

    )

select *
from transformed
