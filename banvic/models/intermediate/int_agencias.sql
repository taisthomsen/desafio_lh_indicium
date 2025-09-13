with
    source as (
        select *
        from {{ ref('stg_erp__agencias') }}
    )

    , transformed as (
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
from transformed
