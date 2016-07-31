from django.conf.urls import patterns, url
from .views import RegisterPatientView, PatientView, PatientDeleteView, PatientDetailView, PatientHistoryDetailView,CallReportView

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'SkinExperts.views.home', name='home'),
    # url(r'^SkinExperts/', include('SkinExperts.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^$', PatientView.as_view(), name="patient_list"),
    url(r'^add/$', RegisterPatientView.as_view(), name="register_patient"),
    url(r'^edit/(?P<id>[0-9]+)$', RegisterPatientView.as_view(), name="edit_patient"),
    url(r'^delete/$', PatientDeleteView.as_view(), name="delete_patient"),
    url(r'^contact/(?P<id>[-\w]+)$', PatientDetailView.as_view(), name="contact_patient"),
    url(r'^history/(?P<id>[-\w]+)$', PatientHistoryDetailView.as_view(), name="patient_history"),
    url(r'^report/(?P<id>[-\w]+)$',CallReportView.as_view(),name='call_reporting')
    
)
