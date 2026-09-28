with voyages as (

    select * from {{ ref('voyages') }}

),

ref_fe as (

    select * from {{ ref('ref_fe') }}

),

joined as (

    select
        v.Invoice_Month as mois,
        v.Primary_Product_Code as type_produit,
        f.KPI_FE as type_transport_fe,
        sum(v."O&D_Net_Count") as total_voyages,
        avg(f.Valeur_FE) as facteur_emission,
        sum(v."O&D_Net_Count" * f.Valeur_FE) as total_emissions_co2

    from voyages v
    left join ref_fe f
        on (v.Primary_Product_Code = 'Air' and f.KPI_FE = 'Avion')
        or (v.Primary_Product_Code = 'Rail' and f.KPI_FE = 'Train')

    where v.Invoice_Month like '%202208%' 
       or v.Invoice_Month like '%202209%'
       or v.Invoice_Month like '%août%'
       or v.Invoice_Month like '%septembre%'

    group by 1, 2, 3

)

select * from joined