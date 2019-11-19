INSERT INTO trend_directory.view_materialization_trend_store_link(view_materialization_id, table_trend_store_part_id, timestamp_mapping_func)
SELECT vm.id, ttsp.id, 'trend.mapping_id(timestamp with time zone)'::regprocedure
FROM trend_directory.view_materialization vm, trend_directory.table_trend_store_part ttsp
WHERE vm::text = 'node_kpi_300' and ttsp in ('u2020-pm_Cell_1_900');


CREATE OR REPLACE FUNCTION trend."node_kpi_300_fingerprint"(timestamp with time zone)
    RETURNS trend_directory.fingerprint
AS $$
    SELECT modified.end, format('{"u2020-pm_Cell_1_900": "%s"}', modified.end)::jsonb
    FROM trend_directory.modified
    JOIN trend_directory.table_trend_store_part ttsp ON ttsp.id = modified.table_trend_store_part_id
    WHERE ttsp::name = 'u2020-pm_Cell_1_900' AND modified.timestamp = $1;
$$ LANGUAGE sql STABLE;

