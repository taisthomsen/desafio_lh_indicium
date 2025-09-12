with
    transacoes as (
        select *
        from {{ ref('int_transacoes') }}
    )

    ,contas as (
        select *
        from {{ ref('stg_erp__contas') }}
    )
    ,cotacao as (
        select *
        from {{ ref('stg_erp__cotacao') }}
    )
    ,clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    ,agencias as (
        select *
        from {{ ref('dim_agencias') }}
    )


    ,joined as (
        select
            -- Primary Key
            t.transacao_pk
            
            -- Foreign Keys
            ,co.cod_cliente_id as cliente_fk
            ,a.agencia_pk as agencia_fk
            
            -- Transaction Details
            ,t.cod_transacao_id
            ,t.num_conta_id
            ,t.data_transacao
            ,t.data_transacao_date
            ,t.ano
            ,t.mes
            ,t.dia_semana
            ,t.mes_par_impar
            ,t.nome_transacao
            ,t.valor_transacao
            ,t.valor_abs
            ,t.entrada_saida
            
            -- Client Information
            ,cl.nome_completo as cliente_nome
            ,cl.tipo_cliente_desc
            ,cl.idade_anos as cliente_idade
            ,cl.dias_desde_inclusao as cliente_dias_cadastro
            
            -- Agency Information
            ,a.nome as agencia_nome
            ,a.cidade as agencia_cidade
            ,a.uf as agencia_uf
            ,a.tipo_agencia
            
            -- Account Information
            ,co.tipo_conta
            ,co.saldo_total
            ,co.saldo_disponivel
            ,co.data_abertura as conta_data_abertura
            ,co.data_ultimo_lancamento as conta_ultimo_lancamento

            ,c.cotacao

        from transacoes t
        left join contas co
            on t.num_conta_id = co.num_conta_id
        left join clientes cl
            on co.cod_cliente_id = cl.cliente_pk
        left join agencias a
            on co.cod_agencia_id = a.agencia_pk
        left join cotacao c
            on t.data_transacao = c.date_id
    )

select *
from joined
            