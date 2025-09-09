with 
    source as (
        select * 
        from {{ source('banvic_raw', 'colaborador_agencia') }}
    )

    ,renamed as (
        select 
            --Primary Key
            cast(cod_colaborador as varchar) as cod_colaborador_id
            ,cast(cod_agencia as varchar) as cod_agencia_id
        from source
    )
 
select *
from renamed
