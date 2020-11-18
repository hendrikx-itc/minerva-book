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
materializations. For these materializations, the following components are
required:

 - A view with a specific format
 - A target trend store part with the exact same columns as defined in the view
 - A record in the trend_directory.view_materialization table
 - Relations between the view materialization and source trend store parts
 - A fingerprint function

View
~~~~

We start by defining the view with the required calculations and transformations. A

.. literalinclude:: view_materialization_example_view.sql
   :language: psql

Then create the view using psql::

    $ psql -f view_materialization_example_view.sql
    CREATE VIEW

Target Table Trend Store Part
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now we define a target table trend store part using the YAML format:

.. literalinclude:: view_materialization_target.yaml

And create the trend store::

    $ minerva trend-store create --from-yaml view_materialization_target.yaml
    Creating trend store 'node_kpi_300' - 'Node'... OK

A Record In trend_directory.view_materialization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is done using a simple insert:

.. literalinclude:: view_materialization_example_register.sql
   :language: psql

Run the script::

    $ psql -f view_materialization_example_register.sql
    INSERT 0 1

Link Materialization To It's Sources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. literalinclude:: view_materialization_example_links.sql
   :language: psql

Run the script::

    $ psql -f view_materialization_example_links.sql
    INSERT 0 1

Define A Fingerprint Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The fingerprint function is a function that must return a different fingerprint
whenever one of the sources has changed for the specified timestamp. To achieve
this, we take the last modified timestamp of each of the sources and combine
that in the json part of the fingerprint:

.. literalinclude:: view_materialization_example_fingerprint.sql
   :language: plpgsql

Create the fingerprint function::

    $ psql -f view_materialization_example_fingerprint.sql
    CREATE FUNCTION

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
