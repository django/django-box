#!/bin/bash

# Smoke tests for the djangobox.
# To run this script inside the VM:
# $ source /vagrant/box-tests.sh

set -x  # To output the commands as they are run.

runtests2.7-spatialite gis_tests
runtests2.7-postgis gis_tests
runtests2.7-sqlite3 auth_tests
runtests2.7-postgresql auth_tests
runtests2.7-mysql auth_tests

runtests3.4-spatialite gis_tests
runtests3.4-postgis gis_tests
runtests3.4-sqlite3 auth_tests
runtests3.4-postgresql auth_tests
runtests3.4-mysql auth_tests

runtests3.5-spatialite gis_tests
runtests3.5-postgis gis_tests
runtests3.5-sqlite3 auth_tests
runtests3.5-postgresql auth_tests
runtests3.5-mysql auth_tests

runtests2.7-sqlite3 admin_widgets --selenium chrome

set +x
