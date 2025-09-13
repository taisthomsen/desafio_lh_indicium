{{ config(
    materialized='table',
    indexes=[
        {'columns': ['data_id'], 'unique': True},
        {'columns': ['ano', 'mes']},
        {'columns': ['ano', 'trimestre']},
        {'columns': ['eh_fim_de_semana']}
    ]
) }}

with
recursive
    datas_dias as (
        select to_date('{{ var("start_date") }}', 'YYYY-MM-DD') as data_dia
        union all
        select cast(data_dia + interval '1 day' as date)
        from datas_dias
        where cast(data_dia + interval '1 day' as date) <= to_date('{{ var("end_date") }}', 'YYYY-MM-DD')
    )

    , transformed as (
        select
            data_dia as data_id

            , extract(year from data_dia) as ano
            , extract(quarter from data_dia) as trimestre
            , extract(month from data_dia) as mes
            , extract(day from data_dia) as dia
            , extract(doy from data_dia) as dia_do_ano

            , to_char(data_dia, 'Month') as nome_mes
            , to_char(data_dia, 'Mon') as nome_mes_abrev
            , lpad(cast(extract(month from data_dia) as text), 2, '0') as mes_formatado

            , extract(week from data_dia) as semana_do_ano
            , extract(dow from data_dia) as dia_semana_num
            , to_char(data_dia, 'Day') as nome_dia
            , to_char(data_dia, 'Dy') as nome_dia_abrev

            , coalesce(extract(dow from data_dia) in (0, 6), false) as eh_fim_de_semana
            , coalesce(extract(dow from data_dia) in (1, 2, 3, 4, 5), false) as eh_dia_util

            , case
                when extract(month from data_dia) in (12, 1, 2) then 'Verão'
                when extract(month from data_dia) in (3, 4, 5) then 'Outono'
                when extract(month from data_dia) in (6, 7, 8) then 'Inverno'
                else 'Primavera'
            end as estacao

            , case
                when mod(extract(month from data_dia), 2) = 0 then 'Par'
                else 'Ímpar'
            end as mes_par_impar

            , case
                when extract(month from data_dia) <= 3 then 1
                when extract(month from data_dia) <= 6 then 2
                when extract(month from data_dia) <= 9 then 3
                else 4
            end as semestre

            , to_char(data_dia, 'YYYY-MM-DD') as data_completa
            , to_char(data_dia, 'DD/MM/YYYY') as data_brasileira
            , cast(to_char(data_dia, 'YYYYMM') as int) as ano_mes
            , to_char(data_dia, 'YYYY-Q') as ano_trimestre

            , case
                when data_dia = current_date then 'Hoje'
                when data_dia = current_date - interval '1 day' then 'Ontem'
                when data_dia = current_date + interval '1 day' then 'Amanhã'
                when data_dia < current_date then 'Passado'
                else 'Futuro'
            end as periodo_relativo

            , current_date - data_dia as dias_desde_hoje

            , extract(isoyear from data_dia) as ano_iso
            , extract(isodow from data_dia) as dia_semana_iso

        from datas_dias
    )

select *
from transformed
