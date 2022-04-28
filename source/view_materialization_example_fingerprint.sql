CREATE OR REPLACE FUNCTION trend."node_kpi_300_fingerprint"(timestamp with time zone)
    RETURNS trend_directory.fingerprint
AS $$
    SELECT modified.end, format('{"u2020-pm_Cell_1_900": "%s"}', modified.end)::jsonb
    FROM trend_directory.modified
    JOIN trend_directory.trend_store_part ttsp ON ttsp.id = modified.trend_store_part_id
    WHERE ttsp::name = 'u2020-pm_Cell_1_900' AND modified.timestamp = $1;
$$ LANGUAGE sql STABLE;

