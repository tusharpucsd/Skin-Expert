from django.conf.urls import patterns, include, url
from .views import typeahead_autocomplete

urlpatterns = patterns('',
    url(r'^name_autocomplete/$', typeahead_autocomplete,name="autocomplete_prop"),
)
