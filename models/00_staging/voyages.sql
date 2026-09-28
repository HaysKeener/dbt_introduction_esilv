select * from {{ source("dbt_intro", "voyage_08_2022") }}

union all

select * from {{ source("dbt_intro", "voyage_09_2022") }}