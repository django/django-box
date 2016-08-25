#!/bin/bash

# Smoke tests for the django-box.
# To run this script inside the VM:
# $ source /vagrant/box-tests.sh

set -x  # To output the commands as they are run.
date -Is

runtests27-sqlite3-gis gis_tests
runtests27-postgres-gis gis_tests
runtests27-mysql-gis gis_tests
runtests27-sqlite3 auth_tests
runtests27-postgres auth_tests
runtests27-mysql auth_tests

runtests34-sqlite3-gis gis_tests
runtests34-postgres-gis gis_tests
runtests34-mysql-gis gis_tests
runtests34-sqlite3 auth_tests
runtests34-postgres auth_tests
runtests34-mysql auth_tests

runtests35-sqlite3-gis gis_tests
runtests35-postgres-gis gis_tests
runtests35-mysql-gis gis_tests
runtests35-sqlite3 auth_tests
runtests35-postgres auth_tests
runtests35-mysql auth_tests

runtests27-sqlite3 admin_widgets --selenium chrome
runtests-flake8
runtests-docs
runtests-isort
runtests-javascript

date -Is
set +x
