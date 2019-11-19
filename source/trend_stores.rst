Trend Stores
============

Trend stores are used to store time series data, or trend data.

Setting Up Trend Stores
-----------------------

Trend stores are defined using YAML files in a specific format. Here is an example of a simple trend store definition:

.. literalinclude:: trend_store_example.yaml

You can create the defined trend store in the minerva database using the following command::

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


Modifying Trend Stores
----------------------

When a Minerva database is configured, at some point, you probably will want to
modify an existing trend store. You might want to:

- Add trends
- Remove trends
- Change data type of trends

To do this, you always first update the definition YAML file. Then you can let
Minerva determine what needs to be changed in the database. This has the
benefit that you can never change the database and then forget to update your
definition files.

Add Trends
~~~~~~~~~~

First add trends in the definition file:

.. literalinclude:: trend_store_example_add_trends.yaml

Then use the following command to add the new trends to the database::

   $ minerva trend-store add-trends --from-yaml trend_store_example_add_trends.yaml
   Adding trends to trend store 'node-concentrator' - 'Node' - '300s' ... OK


Remove Trends
~~~~~~~~~~~~~

Change Data Type Of Trends
~~~~~~~~~~~~~~~~~~~~~~~~~~

