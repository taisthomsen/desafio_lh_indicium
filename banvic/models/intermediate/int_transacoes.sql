with 

    transacoes as (
        select * 
        from {{ ref('stg_erp__transacoes') }}
    )

    , contas as (
        select * 
        from {{ ref('stg_erp__contas') }}
    )

    , transformed as (
        select
             -- Primary key 
            t.cod_transacao_id as transacao_pk
            ,t.cod_transacao_id
            ,t.num_conta_id
            ,c.cod_agencia_id
            ,t.data_transacao
            ,cast(t.data_transacao as date) as data_transacao_date
            ,t.nome_transacao
            ,t.valor_transacao
            ,abs(t.valor_transacao) as valor_abs
            ,case 
                when t.valor_transacao > 0 then 'entrada'
                when t.valor_transacao < 0 then 'saida'
                else 'neutro'
            end as entrada_saida

        from transacoes t
        left join contas c
            on c.num_conta_id = t.num_conta_id    
    )

select *
from transformed