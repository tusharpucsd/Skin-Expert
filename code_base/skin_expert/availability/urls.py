from django.conf.urls import patterns, url
from availability import views

urlpatterns = patterns('',
    url(
        r'^(?:calendar/)?$', 
        views.month_view, 
        name='today'
    ),

    url(
        r'^calendar/(?P<year>\d{4})/$', 
        views.year_view, 
        name='yearly-view'
    ),

    url(
        r'^calendar/(\d{4})/(0?[1-9]|1[012])/$', 
        views.month_view, 
        name='monthly-view'
    ),
    url(
        r'^events/add/$', 
        views.add_event, 
        name='add-event'
    ),
    url(
        r'^set/$', 
        views.set_event, 
        name='set-event'
    ),    
)
