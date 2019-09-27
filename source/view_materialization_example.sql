CREATE VIEW trend."_node_kpi_300" AS
SELECT
    timestamp,
    entity_id,
    pickups / drops AS drop_ratio
FROM trend."node-concentrator_node_300"
GROUP BY timestamp, entity_id;


INSERT INTO trend_directory.view_materialization(dst_trend_store_part_id, processing_delay, stability_delay, reprocessing_period, src_view, enabled, cost)
SELECT id, '30m'::interval, '5m'::interval, '3 days'::interval, 'trend._node_kpi_300'::regclass, true, 10
FROM trend_directory.table_trend_store_part
WHERE name = 'node-concentrator_node_300';


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

