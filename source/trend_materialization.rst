Trend Materialization
=====================

For pre-calculation of KPIs or aggregations, Minerva has support for trend
materialization. PostgreSQL provides materialized views to populate tables
based on a view. This is useful for calculations/transformations that are too
slow to calculate each time the data is required. Unfortunately, PostgreSQL
only supports materializing the whole table in one go. Because the tables for
trend data are meant to be used for very large sets, Minerva has it's own
materialization mechanism that incrementally materializes data based on what
chunks are modified.

The materialization mechanism supports 2 different types that each has it's own
pros and cons:

1. View-based trend materialization
2. Function-based trend materialization

Both types of materializations are defined using a YAML file with a specific
format.


View-Based Trend Materialization
--------------------------------

The easiest method for materializing trend data is by using view
materializations. For these materializations, the following components are
required:

 - A target trend store part with the trends that we want to have calculated
 - A view with a specific format and the exact same columns as defined in the
   target trend store.
 - Relations between the view materialization and source trend store parts
 - A fingerprint function

The specifications are defined in a YAML file with the following format:

.. literalinclude:: hub-kpi_node_15m.yaml
   :language: yaml

Target Table Trend Store Part
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We define a target table trend store part using the YAML format:

.. literalinclude:: view_materialization_target.yaml

And create the trend store::

    $ minerva trend-store create source/view_materialization_target.yaml
    Creating trend store 'node_kpi' - 'Node' - '900s' ... OK

View
~~~~

The view is what defines the actual transformations and calculations. Only the
SELECT query that defines the view needs to be specified, but it needs to have
the following format::

    SELECT
        <TIMESTAMP>,
        <ENTITY_ID>,
        <VALUE_1>,
        ...,
        <VALUE_n>
   FROM <SOURCES>

Where TIMESTAMP needs to be of time timestamptz, ENTITY_ID needs to be a bigint
and the value columns need to match the data types of the target trend store.

Fingerprint Function
~~~~~~~~~~~~~~~~~~~~

The fingerprint function is a function that must return a different fingerprint
whenever one of the sources has changed for the specified timestamp. To achieve
this, we take the last modified timestamp of each of the sources and combine
that in the JSON part of the fingerprint:

.. literalinclude:: view_materialization_example_fingerprint.sql
   :language: plpgsql

Again, only the SELECT query of the fingerprint function needs to be defined,
but it needs to have the following format::

    SELECT
        <MAX_MODIFIED>,
        <FINGERPRINT>
    FROM <MODIFIED_SOURCES>

Where MAX_MODIFIED needs to be of type timestamptz, FINGERPRINT needs to be of
type json and the MODIFIED_SOURCES is taken from the trend_directory.modified
table.

Create Materialization
~~~~~~~~~~~~~~~~~~~~~~

To create the materialization, we use the following command::

    $ minerva trend-materialization create source/hub-kpi_node_15m.yaml
    Created materialization 'hub-kpi_node_main_15m'
  

Function-Based Trend Materialization
------------------------------------

The most powerfull method for materializing trend data is by using function 
materializations. For these materializations, the following components are
required:

 - A function with a specific return type and arguments
 - A target trend store part with the exact same columns as defined in the function return type
 - Relations between the view materialization and source trend store parts
 - A fingerprint function


Manual Materialization
----------------------

When you want to test a materialization, or rerun a previously run
materialization, you can do that using the following SQL command::

    SELECT
        trend_directory.materialize(m, '2020-10-17 13:00')
    FROM trend_directory.materialization m
    WHERE m::text = 'node-concentrator_node_5m';

Keep in mind that the text representation of a materialization is the same as
the name of the target trend store part, which in turn is the same as the
corresponding table name.
