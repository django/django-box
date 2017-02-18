#!/bin/bash

# Smoke tests for the django-box.
# To run this script inside the VM:
# $ source /vagrant/box-tests.sh

set -x  # To output the commands as they are run.
date -Is

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

runtests36-sqlite3-gis gis_tests
runtests36-postgres-gis gis_tests
runtests36-mysql-gis gis_tests
runtests36-sqlite3 auth_tests
runtests36-postgres auth_tests
runtests36-mysql auth_tests

runtests36-sqlite3 admin_widgets --selenium chrome --parallel 1
runtests-flake8
runtests-docs
runtests-isort

date -Is
set +x
