Development setup
=================

The most basic setup with a local Minerva database in a Docker container is
useful for development of a Minerva instance or ad-hoc processing of data.

Prerequisites
-------------

For running a local Minerva database in a Docker container and communicating
with it, you will need:

* `Docker <https://www.docker.com>`_
* `Minerva administration tools <https://github.com/hendrikx-itc/minerva-admin/releases/download/v1.0.0/minerva-admin>`_


Install Docker
~~~~~~~~~~~~~~

On Ubuntu, installing Docker can be done using the standard package manager::

    $ sudo apt install docker.io


Install Minerva administration tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To install the Minerva administration tools, use the default installation
script of the minerva-admin repository::

    $ curl -sS https://raw.githubusercontent.com/hendrikx-itc/minerva-admin/master/install.sh | sh


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

Running a simple task like generating an instance definition dump::

    $ PGHOST=127.0.0.1 PGDATABASE=minerva PGUSER=postgres minerva-admin dump


This of course returns an empty dump, because we haven't configured the Minerva
instance yet.

It can be a bit cumbersome having to prefix each command with those variables
PGHOST etc., so we usually store them in a small shell script named e.g.
``connection_settings.sh``:

.. literalinclude:: environment_variables.sh
   :language: bash

Then to make the variables available in a terminal session, you can use the
following command::

    $ source connection_settings.sh

Now, for any further ``minerva`` commands, we can now omit the environment
variables::

    $ minerva-admin dump
