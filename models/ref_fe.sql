select * from 
{{ source("dbt_intro", "REF_FE_Voyage") }}