{{ config(
    materialized='table',
    indexes=[
        {'columns': ['date_id'], 'unique': True},
        {'columns': ['ano', 'mes']},
        {'columns': ['ano', 'trimestre']},
        {'columns': ['eh_fim_de_semana']}
    ]
) }}

with   
    recursive dates as (
    -- Date range: 5 years back from current date to 2 years forward
     select cast(current_date - interval '5 years' as date) as date_day
         union all
            select cast(date_day + interval '1 day' as date)
                from dates
                    where cast(date_day + interval '1 day' as date) <= cast(current_date + interval '2 years' as date)
)


    ,transformed as (
        select
            -- Primary Key
            date_day as date_id
    
            -- Basic Date Components
            ,extract(year from date_day) as ano
            ,extract(quarter from date_day) as trimestre
            ,extract(month from date_day) as mes
            ,extract(day from date_day) as dia
            ,extract(doy from date_day) as dia_do_ano
    
            -- Month Information
            ,to_char(date_day, 'Month') as nome_mes
            ,to_char(date_day, 'Mon') as nome_mes_abrev
            ,lpad(extract(month from date_day)::text, 2, '0') as mes_formatado
    
            -- Week Information
            ,extract(week from date_day) as semana_do_ano
            ,extract(dow from date_day) as dia_semana_num -- 0=Sunday, 1=Monday, etc.
            ,to_char(date_day, 'Day') as nome_dia
            ,to_char(date_day, 'Dy') as nome_dia_abrev
    
            -- Business Flags
            ,case 
                when extract(dow from date_day) in (0, 6) then true 
                else false 
            end as eh_fim_de_semana
            
            ,case 
                when extract(dow from date_day) in (1, 2, 3, 4, 5) then true 
                else false 
            end as eh_dia_util
            
            ,case 
                when extract(month from date_day) in (12, 1, 2) then 'Verão'
                when extract(month from date_day) in (3, 4, 5) then 'Outono'
                when extract(month from date_day) in (6, 7, 8) then 'Inverno'
                else 'Primavera'
            end as estacao
            
            ,case 
                when mod(extract(month from date_day), 2) = 0 then 'Par'
                else 'Ímpar'
            end as mes_par_impar
            
            -- Financial Periods
            ,case 
                when extract(month from date_day) <= 3 then 1
                when extract(month from date_day) <= 6 then 2
                when extract(month from date_day) <= 9 then 3
                else 4
            end as semestre
            
            -- Date Formatting
            ,to_char(date_day, 'YYYY-MM-DD') as data_completa
            ,to_char(date_day, 'DD/MM/YYYY') as data_brasileira
            ,to_char(date_day, 'YYYYMM')::int as ano_mes
            ,to_char(date_day, 'YYYY-Q') as ano_trimestre
            
            -- Relative Dates
            ,case 
                when date_day = current_date then 'Hoje'
                when date_day = current_date - interval '1 day' then 'Ontem'
                when date_day = current_date + interval '1 day' then 'Amanhã'
                when date_day < current_date then 'Passado'
                else 'Futuro'
            end as periodo_relativo
            
            -- Age in days from a reference date (useful for analysis)
            ,current_date - date_day as dias_desde_hoje
            
            -- ISO Week (Monday as first day of week)
            ,extract(isoyear from date_day) as ano_iso
            ,extract(isodow from date_day) as dia_semana_iso -- 1=Monday, 7=Sunday
            
            -- Metadata
            ,current_timestamp as created_at
            ,'dim_dates' as source_table

        from dates
    )

select *
from transformed
