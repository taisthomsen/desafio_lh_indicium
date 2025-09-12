with 
    source as (
        select * from {{ source('cotacao', 'usd_brl') }}
    )
    ,transformed as (
        select
            cast(to_timestamp(close_date, 'DD/MM/YYYY HH24:MI:SS') as date) as date_id
            , cast(exchange_rate_br as float) as cotacao
        from source
    )

select * 
from transformed
    