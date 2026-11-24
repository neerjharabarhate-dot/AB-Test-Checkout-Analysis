---PHASE 1:- Creating Database,Table,Importing Data, Verfiying Data.---

-- Creating AB Testing Table
create table ab_test_raw(
	user_id integer,
	variant varchar(20),
	converted integer
);

-- Verifying imported Data
select count(*) from ab_test_raw;

-- View First 10 records

select * from ab_test_raw limit 10;

---PHASE 2:- Experiment Group Analysis---
select variant,
	-- 1. Total users assigned to the group:
	count(*) as total_users_for_specific_group,

	-- 2. Users with recorded conversion outcomes:
	count(converted) as users_with_observed_outcomes,

	-- 3. Users who converted:
	sum(case
		when converted=1 then 1
		else 0
	end)as converted_users,

	-- 4. Users who did not convert:
	sum(case
		when converted=0 then 1
		else 0
end) as non_converted_users,
	-- 5. Conversion Rate
	round(
		100.0*sum(case when converted = 1 then 1 else 0 end) /
		nullif(count(converted),0),
		2
	) as conversion_rate_pct,
	
	-- 6. percentage of users allocated to each group
	round(
		100.0 * count(*) /
		(select count(*) from ab_test_raw),2
	) as group_allocation_pct
from ab_test_raw
group by variant
order by variant;

-- Phase 3 : Conversion Perfomance Comparison

with group_metrics as(
	select
		variant,
		count(*) as total_users,
		sum(converted) as converted_users,
		round(avg(converted)*100,2) as conversion_rate_pct
	from ab_test_raw
	group by variant
)

--Relative_lift_pct---
select 
	control.conversion_rate_pct as control_conversion_rate,
	treatment.conversion_rate_pct as treatment_conversion_rate,
	round(
		100.0* (
		treatment.conversion_rate_pct - control.conversion_rate_pct)/
		nullif(control.conversion_rate_pct,0),2
	) as relative_lift_pct,

--- Higher Conversion variant ---
	case 
		when treatment.conversion_rate_pct > control.conversion_rate_pct
			then 'Treatment'
		when treatment.conversion_rate_pct < control.conversion_rate_pct
			then 'Control'
		else 'equal'
	end as higher_conversion_variant

from group_metrices as control
cross join group_metrices as treatment

where control.variant='Control'
and treatment.variant='Treatment';

--- PHASE 5 – SQL Reconciliation and Final Output ---

-- Check tabble Structure --
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'ab_test_raw'
ORDER BY ordinal_position;

-- Checking groups:
SELECT DISTINCT variant
FROM ab_test_raw
ORDER BY variant;

-- Check Data Quality:
SELECT
    COUNT(*) AS total_records,

    COUNT(user_id) AS valid_user_ids,

    COUNT(variant) AS valid_variants,

    COUNT(converted) AS observed_outcomes,

    COUNT(*) - COUNT(user_id) AS missing_user_ids,

    COUNT(*) - COUNT(variant) AS missing_variants,

    COUNT(*) - COUNT(converted) AS missing_outcomes,

    SUM(CASE
        WHEN converted NOT IN (0, 1) THEN 1
        ELSE 0
    END) AS invalid_conversion_values,

    COUNT(DISTINCT user_id) AS unique_users

FROM ab_test_raw;

-- Check Duplicate user ID'S
SELECT
    user_id,
    COUNT(*) AS occurrence_count
FROM ab_test_raw
GROUP BY user_id
HAVING COUNT(*) > 1;

-- SQL & Python reconciliation

with group_metrics as (
    select
        variant,
        count(*) as total_users,
        count(converted) as observed_outcomes,
        sum(case when converted = 1 then 1 else 0 end) as converted_users,
        sum(case when converted = 0 then 1 else 0 end) as non_converted_users,

        round(
            100.0 * sum(case when converted = 1 then 1 else 0 end) /
            nullif(count(converted), 0),
            2
        ) as conversion_rate_pct

    from ab_test_raw
    group by variant
),

comparison as (
    select
        control.total_users as control_total_users,
        treatment.total_users as treatment_total_users,

        control.observed_outcomes as control_observed_outcomes,
        treatment.observed_outcomes as treatment_observed_outcomes,

        control.converted_users as control_converted_users,
        treatment.converted_users as treatment_converted_users,

        control.non_converted_users as control_non_converted_users,
        treatment.non_converted_users as treatment_non_converted_users,

        control.conversion_rate_pct as control_conversion_rate,
        treatment.conversion_rate_pct as treatment_conversion_rate

    from group_metrics as control

    cross join group_metrics as treatment

    where control.variant = 'Control'
      and treatment.variant = 'Treatment'
)

select
    *,

    round(
        treatment_conversion_rate - control_conversion_rate,
        2
    ) as absolute_difference_pp,

    round(
        100.0 * (
            treatment_conversion_rate - control_conversion_rate
        ) / nullif(control_conversion_rate, 0),
        2
    ) as relative_lift_pct

from comparison;
