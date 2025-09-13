with
    source as (
        select *
        from {{ source('banvic_raw', 'clientes') }}
    )

    , renamed as (
        select
            cast(cod_cliente as varchar) as cliente_id
            , cast(primeiro_nome as varchar) as primeiro_nome
            , cast(ultimo_nome as varchar) as ultimo_nome
            , cast(email as varchar) as email
            , cast(tipo_cliente as varchar) as tipo_cliente
            , cast(data_inclusao as date) as data_inclusao
            , cast(cpfcnpj as varchar) as cpfcnpj
            , cast(data_nascimento as date) as data_nascimento
            , cast(endereco as varchar) as endereco
            , cast(cep as varchar) as cep
        from source
    )

select *
from renamed
