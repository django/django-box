from test_sqlite3 import *  # NOQA

DATABASES = {
    'default': {
        'ENGINE': 'django.contrib.gis.db.backends.mysql',
        'USER': 'django',
        'PASSWORD': 'secret',
        'NAME': 'django_gis',
        'OPTIONS': {
            'init_command': 'SET default_storage_engine=MyISAM',
        },
        'TEST': {
            'CHARSET': 'utf8',
            'COLLATION': 'utf8_general_ci',
        },
    },
    'other': {
        'ENGINE': 'django.contrib.gis.db.backends.mysql',
        'USER': 'django',
        'PASSWORD': 'secret',
        'NAME': 'django2_gis',
        'OPTIONS': {
            'init_command': 'SET default_storage_engine=MyISAM',
        },
        'TEST': {
            'CHARSET': 'utf8',
            'COLLATION': 'utf8_general_ci',
        },
    },
}
