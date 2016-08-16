import os
import platform

from test_sqlite import *  # NOQA

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    },
    'memcached': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '127.0.0.1:11211',
    }
}

if platform.python_implementation() == "PyPy":
    # disable memcached
    CACHES['memcached']['BACKEND'] = 'django.core.cache.backends.dummy.DummyCache'

GEOIP_PATH = os.path.join(os.environ['HOME'], 'geoip')
SPATIALITE_LIBRARY_PATH = 'mod_spatialite'
