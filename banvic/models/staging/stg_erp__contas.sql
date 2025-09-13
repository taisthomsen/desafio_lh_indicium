with
    source as (
        select *
        from {{ source('banvic_raw', 'contas') }}
    )

    , renamed as (
        select
            cast(num_conta as varchar) as conta_id
            , cast(cod_cliente as varchar) as cliente_id
            , cast(cod_agencia as varchar) as agencia_id
            , cast(cod_colaborador as varchar) as colaborador_id
            , cast(tipo_conta as varchar) as tipo_conta
            , cast(data_abertura as date) as data_abertura
            , cast(saldo_total as float) as saldo_total
            , cast(saldo_disponivel as float) as saldo_disponivel
            , cast(data_ultimo_lancamento as date) as data_ultimo_lancamento
        from source
    )

select *
from renamed
