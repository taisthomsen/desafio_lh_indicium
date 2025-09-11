with 
    source as (
        select * 
        from {{ source('banvic_raw', 'propostas_credito') }}
    )

    ,renamed as (
        select 
            --Primary Key
            cast(cod_proposta as varchar) as cod_proposta_id
            --Foreign Key
            ,cast(cod_cliente as varchar) as cod_cliente_id
            ,cast(cod_colaborador as varchar) as cod_colaborador_id
            --Data
            ,cast(data_entrada_proposta as date) as data_entrada_proposta
            ,cast(taxa_juros_mensal as float) as taxa_juros_mensal
            ,cast(valor_proposta as float) as valor_proposta
            ,cast(valor_financiamento as float) as valor_financiamento
            ,cast(valor_entrada as float) as valor_entrada
            ,cast(valor_prestacao as float) as valor_prestacao
            ,cast(quantidade_parcelas as int) as quantidade_parcelas
            ,cast(carencia as int) as carencia
            ,cast(status_proposta as varchar) as status_proposta
        from source
    )
 
select *
from renamed

