Aggregation
===========

For a lot of use cases, the finest granularity of data is not needed. We can
mainly identify 2 types of aggregations:

1. Time aggregation - This is when you aggregate for example from a fine
   granularity like 5 minutes to a courser granularity like daily.
2. Entity aggregation - This is when data from multiple entities or devices is
   grouped to e.g. network level.

These types of aggregations are treated differently to be able to calculate
them as efficient as possible.

Aggregations are implemented in Minerva as materializations.

Time aggregation
----------------

Example:

.. literalinclude:: time_aggregation.yaml
   :language: yaml

Entity aggregation
------------------

Example:

.. literalinclude:: entity_aggregation.yaml
   :language: yaml
