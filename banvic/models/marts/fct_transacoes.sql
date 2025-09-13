with
    transacoes as (
        select *
        from {{ ref('int_transacoes') }}
    )

    ,contas as (
        select *
        from {{ ref('dim_contas') }}
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
            t.transacao_id
            
            -- Foreign Keys
            ,cl.cliente_id 
            ,con.conta_id
            ,a.agencia_id
    
            
            -- Transaction Details
            ,t.cod_transacao_id
            ,t.num_conta_id
            ,t.data_transacao
            ,t.data_transacao_date
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
            ,con.tipo_conta
            ,con.saldo_total
            ,con.saldo_disponivel
            ,con.data_abertura as conta_data_abertura
            ,con.data_ultimo_lancamento as conta_ultimo_lancamento

            ,c.cotacao

        from transacoes t
        left join contas con
            on t.num_conta_id = con.conta_id
        left join clientes cl
            on con.cliente_id = cl.cliente_id
        left join agencias a
            on con.agencia_id = a.agencia_id
        left join cotacao c
            on t.data_transacao = c.date_id
     
    )

select *
from joined
            