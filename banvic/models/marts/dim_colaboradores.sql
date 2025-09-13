with
    source as (
        select *
        from {{ ref('int_colaboradores') }}
    )

    ,renamed as (
        select
            --Primary Key
            colaborador_id
            ,agencia_fk
            ,nome_completo
            ,email
            ,cpf   
            ,idade_anos
            ,endereco
            ,cep

        from source
    )

select *
from renamed





