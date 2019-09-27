Trend Stores
============

Trend stores are used to store time series data, or trend data.

Setting Up Trend Stores
-----------------------

Trend stores are defined using YAML files in a specific format. Here is an example of a simple trend store definition:

.. literalinclude:: trend_store_example.yaml

You can create the defined trend store in the minerva database using the command::

   $ minerva trend-store create --from-yaml trend_store_example.yaml
   Creating trend store 'node-concentrator' - 'Node'... OK

Verify if the trend store is created::

    $ minerva trend-store list
    id |    data_source    | entity_type | granularity
    ---+-------------------+-------------+------------
    1  | node-concentrator | Node        | 0:05:00

Show detailed information about the trend store using the Id found in the
previous output::

	$ minerva trend-store show 1
	Table Trend Store

	id:               1
	entity_type:      Node
	data_source:      node-concentrator
	granularity:      0:05:00
	partition_size:   86400
	retention_period: 30 days, 0:00:00
	parts:
					  node-concentrator_node_300 (1)
					  ==============================
					  id |    name     | data_type
					  ---+-------------+----------
					  1  | pickups     | smallint 
					  2  | drops       | smallint 
					  3  | temperature | float



