with
    source as (
        select *
        from {{ ref('int_clientes') }}
    )

    , renamed as (
        select
            cliente_id
            , nome_completo
            , email
            , tipo_cliente_desc
            , data_inclusao
            , dias_desde_inclusao
            , cpfcnpj
            , idade_anos
            , endereco
            , cep
        from source
    )

select *
from renamed
