with
    source as (
        select *
        from {{ source('banvic_raw', 'agencias') }}
    )

    , renamed as (
        select
            cast(cod_agencia as varchar) as agencia_id
            , cast(nome as varchar) as nome
            , cast(endereco as varchar) as endereco
            , cast(cidade as varchar) as cidade
            , cast(uf as varchar) as uf
            , cast(data_abertura as date) as data_abertura
            , cast(tipo_agencia as varchar) as tipo_agencia
        from source
    )

select *
from renamed
