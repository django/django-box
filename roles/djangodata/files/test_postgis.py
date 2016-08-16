from test_sqlite3 import *  # NOQA

DATABASES = {
    'default': {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'USER': 'vagrant',
        'NAME': 'geodjango',
    },
    'other': {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'USER': 'vagrant',
        'NAME': 'geodjango2',
    },
}
