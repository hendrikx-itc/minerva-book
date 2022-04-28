INSERT INTO trend_directory.view_materialization_trend_store_link(view_materialization_id, trend_store_part_id, timestamp_mapping_func)
SELECT vm.id, ttsp.id, 'trend.mapping_id(timestamp with time zone)'::regprocedure
FROM trend_directory.view_materialization vm, trend_directory.trend_store_part ttsp
WHERE vm::text = 'node-concentrator_node_kpi_300' and ttsp in ('node-concentrator_node_300');
