with
    source as (
        select *
        from {{ source('banvic_raw', 'transacoes') }}
    )

    , renamed as (
        select
            cast(cod_transacao as varchar) as transacao_id
            , cast(num_conta as varchar) as conta_id
            , cast(data_transacao as timestamp) as transacao_timestamp
            , cast(nome_transacao as varchar) as nome_transacao
            , cast(valor_transacao as float) as valor_transacao
        from source
    )

select *
from renamed
