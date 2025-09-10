with
    source as (
        select *
        from {{ ref('stg_erp__agencias') }}
    )

    , transformed as (
        select
            -- Primary key
            cod_agencia_id as agencia_pk
            ,nome
            ,endereco
            ,cidade
            ,uf
            ,data_abertura
            ,extract(year from data_abertura) as ano_abertura
            ,extract(month from data_abertura) as mes_abertura
            ,extract(day from data_abertura) as dia_abertura
            ,tipo_agencia
        from source
    )

select *
from transformed


