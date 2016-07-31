from django.contrib import admin
from availability.models import Occurrence

#===============================================================================
class OccurrenceAdmin(admin.ModelAdmin):
    list_display = ('doctor', )
    search_fields = ('doctor', )
    
admin.site.register(Occurrence, OccurrenceAdmin)
