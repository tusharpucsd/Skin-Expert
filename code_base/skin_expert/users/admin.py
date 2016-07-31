from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.admin import UserAdmin

from users.models import Role, UserProfile

class UserProfileAdmin(admin.StackedInline):
    model = UserProfile
    extra = 1
    max_num = 1
    
class CustomUserAdmin(UserAdmin):
    model = User
    inlines = [UserProfileAdmin, ]
    
admin.site.unregister(User)
admin.site.register(Role)
admin.site.register(User, CustomUserAdmin)