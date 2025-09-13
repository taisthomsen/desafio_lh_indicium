with
    contas as (
        select *
        from {{ ref('stg_erp__contas') }}
    )

    ,renamed as (
        select
            --Primary Key
            num_conta_id as conta_id

            --Foreign Key
            ,cod_cliente_id as cliente_id
            ,cod_agencia_id as agencia_id
            ,cod_colaborador_id as colaborador_id

            --Data
            ,tipo_conta
            ,data_abertura
            ,saldo_total
            ,saldo_disponivel
            ,data_ultimo_lancamento
        
        from contas
    )

select *
from renamed


