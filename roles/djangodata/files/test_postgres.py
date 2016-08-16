from test_sqlite3 import *  # NOQA

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'USER': 'vagrant',
        'NAME': 'django',
    },
    'other': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'USER': 'vagrant',
        'NAME': 'django2',
    },
}
