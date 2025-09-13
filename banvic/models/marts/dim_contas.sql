with
    contas as (
        select *
        from {{ ref('stg_erp__contas') }}
    )

    , renamed as (
        select
            conta_id
            , cliente_id
            , agencia_id
            , colaborador_id
            , tipo_conta
            , data_abertura
            , saldo_total
            , saldo_disponivel
            , data_ultimo_lancamento

        from contas
    )

select *
from renamed
