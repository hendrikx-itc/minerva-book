SELECT trend_directory.define_view_materialization(
    id, '10m'::interval, '5m'::interval, '3 days'::interval, 'trend._node_kpi_300'::regclass
)
FROM trend_directory.trend_store_part
WHERE name = 'node-concentrator_node_kpi_300';
