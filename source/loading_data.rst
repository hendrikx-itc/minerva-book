Loading Data
============

CSV Trend Data
--------------

When one or more trend stores are setup, we can start loading data into those
trend stores. Out of the box, the Minerva admin tooling supports CSV data, but
other data types are supported using plugins::

    $ minerva load-data --list-plugins
    csv

Now we first must make sure that partitions for the whole retention period are
created, so that the data that we need to load will have a target partition to
write it to. This can simply be done using the following command::

    $ minerva trend-store partition create                                                                                       
    node-concentrator_node_5m - 19087 (0/34)
    node-concentrator_node_5m - 19088 (1/34)
    node-concentrator_node_5m - 19089 (2/34)
    node-concentrator_node_5m - 19090 (3/34)
    node-concentrator_node_5m - 19091 (4/34)
    node-concentrator_node_5m - 19092 (5/34)
    node-concentrator_node_5m - 19093 (6/34)
    node-concentrator_node_5m - 19094 (7/34)
    node-concentrator_node_5m - 19095 (8/34)
    node-concentrator_node_5m - 19096 (9/34)
    node-concentrator_node_5m - 19097 (10/34)
    node-concentrator_node_5m - 19098 (11/34)
    node-concentrator_node_5m - 19099 (12/34)
    node-concentrator_node_5m - 19100 (13/34)
    node-concentrator_node_5m - 19101 (14/34)
    node-concentrator_node_5m - 19102 (15/34)
    node-concentrator_node_5m - 19103 (16/34)
    node-concentrator_node_5m - 19104 (17/34)
    node-concentrator_node_5m - 19105 (18/34)
    node-concentrator_node_5m - 19106 (19/34)
    node-concentrator_node_5m - 19107 (20/34)
    node-concentrator_node_5m - 19108 (21/34)
    node-concentrator_node_5m - 19109 (22/34)
    node-concentrator_node_5m - 19110 (23/34)
    node-concentrator_node_5m - 19111 (24/34)
    node-concentrator_node_5m - 19112 (25/34)
    node-concentrator_node_5m - 19113 (26/34)
    node-concentrator_node_5m - 19114 (27/34)
    node-concentrator_node_5m - 19115 (28/34)
    node-concentrator_node_5m - 19116 (29/34)
    node-concentrator_node_5m - 19117 (30/34)
    node-concentrator_node_5m - 19118 (31/34)
    node-concentrator_node_5m - 19119 (32/34)
    node-concentrator_node_5m - 19120 (33/34)


Now all partitions for the full retention period and a little bit into the
future are created.


We will use the following test data to load into the trend store:

.. literalinclude:: test_data.csv
   :language: text

To be able to understand the input data, we need to provide the parser with a
JSON config file. The config file we will use looks like this:

.. literalinclude:: parser_config.json 
   :language: json

The entity type and granularity must match the target trend store that we have
defined.

Now we can load the CSV data into that trend store::

    $ minerva load-data --type csv --parser-config source/parser_config.json --data-source node-concentrator --statistics source/test_data.csv
    Start processing file source/test_data.csv of type csv and config {'timestamp': 'timestamp', 'identifier': 'entity', 'delimiter': ',', 'chunk_size': 5000, 'columns': [{'name': 'pickups', 'data_type': 'smallint'}, {'name': 'drops', 'data_type': 'smallint'}, {'name': 'temperature', 'data_type': 'real'}], 'entity_type': 'node', 'granularity': '5m'}
    packages: 1
    records: 4

Here we added the `--statistics` option, which collects some statistics while
loading and prints them at the end.
