with
    source as (
        select *
        from {{ ref('stg_erp__clientes') }}
    )

    , transformed as (
        select
            cliente_id
            , primeiro_nome
            , ultimo_nome
            , concat(primeiro_nome, ' ', ultimo_nome) as nome_completo
            , email
            , tipo_cliente
            , data_inclusao
            , current_date - data_inclusao as dias_desde_inclusao
            , data_nascimento
            , current_date - data_nascimento as dias_desde_nascimento
            , extract(year from age(current_date, data_nascimento)) as idade_anos
            , case
                when tipo_cliente = 'PF'
                    then 'Pessoa Física'
                when tipo_cliente = 'PJ'
                    then 'Pessoa Jurídica'
                else 'Outro'
            end as tipo_cliente_desc
            , cpfcnpj
            , endereco
            , cep
        from source
    )

select *
from transformed
