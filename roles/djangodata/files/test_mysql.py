from test_sqlite3 import *  # NOQA

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'USER': 'django',
        'PASSWORD': 'secret',
        'NAME': 'django',
        'OPTIONS': {
            'init_command': 'SET default_storage_engine=INNODB',
        },
        'TEST': {
            'CHARSET': 'utf8',
            'COLLATION': 'utf8_general_ci',
        },
    },
    'other': {
        'ENGINE': 'django.db.backends.mysql',
        'USER': 'django',
        'PASSWORD': 'secret',
        'NAME': 'django2',
        'OPTIONS': {
            'init_command': 'SET default_storage_engine=INNODB',
        },
        'TEST': {
            'CHARSET': 'utf8',
            'COLLATION': 'utf8_general_ci',
        },
    },
}
