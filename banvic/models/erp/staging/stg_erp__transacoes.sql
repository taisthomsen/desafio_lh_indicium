with 
    source as (
        select * 
        from {{ source('banvic_raw', 'transacoes') }}
    )

    ,renamed as (
        select 
             --Primary Key
             cast(cod_transacao as varchar) as cod_transacao_id
            --Foreign Key
            ,cast(num_conta as varchar) as num_conta_id
            --Data
            ,cast(data_transacao as date) as data_transacao
            ,cast(nome_transacao as varchar) as nome_transacao
            ,cast(valor_transacao as float) as valor_transacao
        from source
    )

select *
from renamed

