Trend Materialization
=====================

PostgreSQL provides materialized views to populate tables based on a view. This
is useful for calculations/transformations that are too slow to calculate each
time the data is required. Unfortunately, PostgreSQL only supports
materializing the whole table in one go. Because the tables for trend data are
meant to be used for very large sets, Minerva has it's own materialization
method that incrementally materializes data based on what chunks are modified.


View Based Trend Materialization
--------------------------------

The easiest method for materializing trend data is by using view
materializations. For these materializations, you define a view with a specific
format and register it as a view materialization. An example view:

.. literalinclude:: view_materialization_example.sql
   :language: psql

