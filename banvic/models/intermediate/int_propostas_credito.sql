with
    source as (
        select *
        from {{ ref('stg_erp__propostas_credito') }}
    )

    , transformed as (
        select
            -- Primary key
            cod_proposta_id as proposta_id
            ,cod_cliente_id as cliente_id
            ,cod_colaborador_id as colaborador_id
            ,data_entrada_proposta
            ,taxa_juros_mensal
            ,valor_proposta
            ,valor_financiamento
            ,valor_entrada
            ,valor_prestacao
            ,quantidade_parcelas
            ,carencia
            ,status_proposta
        from source
    )

select *
from transformed
