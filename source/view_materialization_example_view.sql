CREATE VIEW trend."_node_kpi_300" AS
SELECT
    timestamp,
    entity_id,
    pickups / drops AS drop_ratio
FROM trend."node-concentrator_node_300"
GROUP BY timestamp, entity_id;
