with
    source as (
        select *
        from {{ source('banvic_raw', 'colaboradores') }}
    )

    , renamed as (
        select
            cast(cod_colaborador as varchar) as colaborador_id
            , cast(primeiro_nome as varchar) as primeiro_nome
            , cast(ultimo_nome as varchar) as ultimo_nome
            , cast(email as varchar) as email
            , cast(cpf as varchar) as cpf
            , cast(data_nascimento as date) as data_nascimento
            , cast(endereco as varchar) as endereco
            , cast(cep as varchar) as cep
        from source
    )

select *
from renamed
