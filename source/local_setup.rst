Development setup
=================

The most basic setup with a local Minerva database in a Docker container is
useful for development of a Minerva instance or ad-hoc processing of data.

Prerequisites
-------------

For running a local Minerva database in a Docker container and communicating
with it, you will need:

* `Docker <https://www.docker.com>`_
* `PostgreSQL client psql <https://www.postgresql.org/docs/current/app-psql.html>`_
* `Minerva administration tools <https://pypi.org/project/minerva-etl/>`_


Install Docker
~~~~~~~~~~~~~~

On Ubuntu, installing Docker can be done using the standard package manager::

    $ sudo apt install docker.io

PostgreSQL client psql
~~~~~~~~~~~~~~~~~~~~~~

On Ubuntu, using the apt, you can install the PostgreSQL client::

    $ sudo apt install postgresql-client

This will install the default PostgreSQL version client for your release of
Ubuntu, and because we do not need any version specific functionality, this is
Ok.


Install Minerva administration tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To install the Minerva administration tools as a Python package::

    $ python3 -m pip install minerva-etl


Starting Minerva
----------------

To start with an empty Minerva instance inside a Docker container and allow
passwordless access to the database::

    $ docker run -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 hendrikxitc/minerva

This will start the container and display the output in the current terminal
window.

Connecting to the database
--------------------------

To connect to the Minerva database using the PostgreSQL client::

    $ psql -h 127.0.0.1 -U postgres minerva

When you run that command, you should end up with the psql command interface
which should look similar to this::

    psql (12.7 (Ubuntu 12.7-0ubuntu0.20.10.1), server 12.6 (Debian 12.6-1.pgdg100+1))
    Type "help" for help.

    minerva=#

Here you can run SQL commands to look around in and interact with the database.
An initial check is to see what Minerva schemas exist in the database::

    minerva=# \dn
              List of schemas
              Name          |  Owner
    ------------------------+----------
     alias                  | postgres
     alias_directory        | postgres
     attribute              | postgres
     attribute_base         | postgres
     attribute_directory    | postgres
     attribute_history      | postgres
     attribute_staging      | postgres
     directory              | postgres
     entity                 | postgres
     logging                | postgres
     metric                 | postgres
     notification           | postgres
     notification_directory | postgres
     olap                   | postgres
     public                 | postgres
     relation               | postgres
     relation_directory     | postgres
     system                 | postgres
     trend                  | postgres
     trend_directory        | postgres
     trend_partition        | postgres
     trigger                | postgres
     trigger_rule           | postgres
     virtual_entity         | postgres
    (24 rows)

These schemas are documented in `the core Minerva documentation <https://minerva.readthedocs.io>`_.

Using Minerva administration tools
----------------------------------

The Minerva administration tools are used initially to configure the Minerva
database to suit the data you want to store in it. In the rest of the
life-cycle it is used for maintenance tasks, trouble-shooting, data loading
etc.

Running a simple task like listing all configured data sources::

    $ PGHOST=127.0.0.1 PGDATABASE=minerva PGUSER=postgres minerva report
    Minerva Instance Report

    Trend Store Metrics

    Data Source | Entity Type | Part Name | Record Count


    Attribute Store Metrics

    Name | Record Count | Unique Entity Count | Max Timestamp


This of course returns an empty report, because we haven't configured the Minerva
instance yet.

