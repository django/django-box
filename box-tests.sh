#!/bin/bash

# Smoke tests for the djangobox.
# To run this script inside the VM:
# $ source /vagrant/box-tests.sh

set -x  # To output the commands as they are run.

runtests27-sqlite3_gis gis_tests
runtests27-postgres_gis gis_tests
runtests27-mysql_gis gis_tests
runtests27-sqlite3 auth_tests
runtests27-postgres auth_tests
runtests27-mysql auth_tests

runtests34-sqlite3_gis gis_tests
runtests34-postgres_gis gis_tests
runtests34-mysql_gis gis_tests
runtests34-sqlite3 auth_tests
runtests34-postgres auth_tests
runtests34-mysql auth_tests

runtests35-sqlite3_gis gis_tests
runtests35-postgres_gis gis_tests
runtests35-mysql_gis gis_tests
runtests35-sqlite3 auth_tests
runtests35-postgres auth_tests
runtests35-mysql auth_tests

runtests27-sqlite3 admin_widgets --selenium chrome
runtests-flake8

set +x
