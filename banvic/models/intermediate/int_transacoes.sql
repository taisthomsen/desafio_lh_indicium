with 

    transacoes as (
        select * 
        from {{ ref('stg_erp__transacoes') }}
    )

    , transformed as (
        select
             -- Primary key 
            cod_transacao_id as transacao_id
            ,cod_transacao_id
            ,num_conta_id
            ,data_transacao
            ,cast(data_transacao as date) as data_transacao_date
            ,nome_transacao
            ,valor_transacao
            ,abs(valor_transacao) as valor_abs
            ,case 
                when valor_transacao > 0 then 'entrada'
                when valor_transacao < 0 then 'saida'
                else 'neutro'
            end as entrada_saida

        from transacoes 
      
    )

select *
from transformed