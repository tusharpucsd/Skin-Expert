from object_log.models import LogAction

def build_cache(user, obj1, obj2, obj3, data):
    """ build cache for default log types """
    return {'object1_str': "%s object - '%s'"%(obj1.__class__.__name__, obj1)} if not data else data

LogAction.objects._register('CREATE', "object_log/create.html", build_cache)
LogAction.objects._register('EDIT', "object_log/edit.html", build_cache)
LogAction.objects._register('DELETE', "object_log/delete.html", build_cache)
LogAction.objects._register('LOGIN', "object_log/login.html", build_cache)
LogAction.objects._register('LOGOUT', "object_log/logout.html", build_cache)


