with
    source as (
        select *
        from {{ ref('int_agencias') }}
    )

    , renamed as (
        select
            agencia_id
            , nome
            , endereco
            , cidade
            , uf
            , data_abertura
            , tipo_agencia
        from source
    )

select *
from renamed
