from functools import wraps
from django.template.response import TemplateResponse


def group_required(*group_names):
    def decorator(func):
        def inner_decorator(request, *args, **kwargs):
            if request.user.is_authenticated():
                if request.user.profile.role and bool(request.user.profile.role.code in group_names):
                    return func(request, *args, **kwargs)
                else:
                    return TemplateResponse(request, '401.html')
        return wraps(func)(inner_decorator)
    return decorator
