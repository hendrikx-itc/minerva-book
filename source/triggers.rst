Triggers
========

Minerva has support for generating notifications based on patterns in the data.
These patterns can be described in SQL and make use of all data that is
available in a Minerva instance.

Like most configuration of Minerva, a trigger is defined by YAML file with a
specific format.

YAML Definition
---------------

An example of a trigger definition in YAML:

.. literalinclude:: trigger_definition.yaml
   :language: yaml

The following components can be identified in a trigger definition:

:name: The name of the trigger that is used to identify and refer to it.
:kpi_data: A definition of the source data columns for this trigger.
:kpi_function: The logic to collect all data required to check for the trigger condition.
:thresholds: The names and data types of thresholds that can be configured for this trigger.
:condition:
    The SQL describing what patterns in the data can be identified to generate a
    notification. This is the core of the trigger logic.
:weight:
    The weight of the resulting notification. This weight can be a constant or
    based on the data that is also used in the trigger condition.
:notification:
    A textual representation of the notification that will be generated if the
    condition is met.
:data:
    A json representation of the data in the notification that will be
    generated if the condition is met.
:tags:
    Tags that will be associated with this trigger to make a user defined
    grouping of triggers. This is usually tied to business processes.
:fingerprint:
:notification_store:
    The notification store where the resulting notifications of this trigger will
    be written.
:trend_store_links: The relations between this trigger and it's source trend stores.
:mapping_functions:
    Any custom mapping functions between the timestamps of source trend stores
    and the timestamp of the resulting notifications. These are only used in
    more complex trigger rules.
:granularity:
    The granularity at which this trigger operates and at which
    notifications can be generated. If the granularity of the trigger
    is e.g. 1 day, then notifications can be generated at most each
    day.

Create Notification Store
-------------------------

The notifications resulting from a trigger are written to the configured
notification store. A notification store has a standard format, but the name
can be chosen. Here is the YAML definition of the notification store we will
use in this example::

.. literalinclude:: trigger_notification_store.yaml
   :language: yaml

To create the notification store, we use the following minerva command::

    $ minerva notification-store create source/trigger_notification_store.yaml 
    Creating notification store 'trigger-notification'... OK

Create Trigger
--------------

To create a trigger in a Minerva instance, we use the following command::

    $ minerva trigger create source/trigger_definition.yaml                         
    Creating trigger 'high_temperature' ...
     - creating KPI type
     - creating KPI function
     - creating rule
     - setting weight
     - setting thresholds
     - setting condition
     - defining notification message
     - defining notification data
     - creating mapping functions
     - link trend stores
