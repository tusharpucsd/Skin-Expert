import socket
hostname = socket.gethostname()


if hostname == "Leopradnya": #local settings for user
    from settings_pradnya import *
elif hostname == "vivek-desktop":
    from settings_vivk import *
elif hostname == "sumegha-desktop":
    from settings_sumegha import *
elif hostname == "Tushar":
    from settings_tushar import *
else:
    from settings_tushar import *
    #raise ImproperlyConfigured("No settings module found for host: %s" % hostname)

del(hostname)