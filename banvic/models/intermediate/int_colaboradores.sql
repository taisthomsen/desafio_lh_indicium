with
    colaboradores as (
        select *
        from {{ ref('stg_erp__colaboradores') }}
    )

    , colaborador_agencia as (
        select *
        from {{ ref('stg_erp__colaborador_agencia') }}
    )

    , transformed as (
        select
            c.colaborador_id
            , ca.agencia_id
            , c.primeiro_nome
            , c.ultimo_nome
            , concat(c.primeiro_nome, ' ', c.ultimo_nome) as nome_completo
            , c.email
            , c.cpf
            , c.data_nascimento
            , extract(year from age(current_date, c.data_nascimento)) as idade_anos
            , c.endereco
            , c.cep
        from colaborador_agencia as ca
        left join colaboradores as c
            on ca.colaborador_id = c.colaborador_id
    )

select *
from transformed
