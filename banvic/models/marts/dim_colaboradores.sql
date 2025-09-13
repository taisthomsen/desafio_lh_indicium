with
    source as (
        select *
        from {{ ref('int_colaboradores') }}
    )

    , renamed as (
        select
            colaborador_id
            , agencia_id
            , data_nascimento
            , nome_completo
            , email
            , cpf
            , idade_anos
            , endereco
            , cep

        from source
    )

select *
from renamed
