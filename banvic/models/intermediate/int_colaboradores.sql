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
            -- Primary key
            c.cod_colaborador_id as colaborador_pk
            ,c.primeiro_nome
            ,c.ultimo_nome
            ,concat(c.primeiro_nome, ' ', c.ultimo_nome) as nome_completo
            ,c.email
            ,c.cpf
            ,c.data_nascimento
            ,extract(year from age(current_date, c.data_nascimento)) as idade_anos
            ,c.endereco
            ,c.cep
            ,ca.cod_agencia_id as agencia_fk
        from colaborador_agencia ca
        left join colaboradores c
            on ca.cod_colaborador_id = c.cod_colaborador_id
    )

select *
from transformed

