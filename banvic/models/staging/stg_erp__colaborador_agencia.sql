with
    source as (
        select *
        from {{ source('banvic_raw', 'colaborador_agencia') }}
    )

    , renamed as (
        select
            cast(cod_colaborador as varchar) as colaborador_id
            , cast(cod_agencia as varchar) as agencia_id
        from source
    )

select *
from renamed
