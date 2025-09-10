with
    source as (
        select *
        from {{ ref('int_agencias') }}
    )

    ,renamed as (
        select
            --Primary Key
            agencia_pk 
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