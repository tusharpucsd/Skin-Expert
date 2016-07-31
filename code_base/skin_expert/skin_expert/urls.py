from django.conf.urls import patterns, include, url
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import TemplateView


# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'SkinExperts.views.home', name='home'),
    # url(r'^SkinExperts/', include('SkinExperts.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^patient/', include('patients.urls')),
    url(r'^task/', include('tasks.urls')),
    url(r'^app/', include('app.urls')),
    url(r'', include('users.urls')),
    url(r'^availbility/', include('availability.urls')),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^address/', include('address.urls')),
    url(r'^privacy/', TemplateView.as_view(template_name="privacy.html"), name='privacy'),
    url(r'^terms/', TemplateView.as_view(template_name="terms.html"), name='terms'),
    url(r'^system/', TemplateView.as_view(template_name="system_update.html"), name="system_update"),
)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

urlpatterns += patterns('',
    (r'^logs/', include('object_log.urls')),
)

#------------------------------------------------------------- django-js-reverse
urlpatterns += patterns('',
    url(r'^jsreverse/$', 'django_js_reverse.views.urls_js', name='js_reverse'),
)
#--------------------------------------------------------------- selectable urls
urlpatterns += patterns('',
    (r'^selectable/', include('selectable.urls')),
)