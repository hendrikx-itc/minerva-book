SELECT modified.last, format('{"hub_node_main_15m": "%s"}', modified.last)::jsonb
FROM trend_directory.modified
JOIN trend_directory.trend_store_part ttsp ON ttsp.id = modified.trend_store_part_id
WHERE ttsp::name = 'hub_node_main_15m' AND modified.timestamp = $1;
