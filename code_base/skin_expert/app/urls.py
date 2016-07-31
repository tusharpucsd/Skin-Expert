from django.conf.urls import patterns, url
from app.views import AppLoginView, AppLogOutView, AppForgotPasswordView, \
    AppEditProfileView, ReportListView, ReportDetailView, EpisodeAddView, \
    AppChangePasswordView, AppContactView


urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'SkinExperts.views.home', name='home'),
    # url(r'^SkinExperts/', include('SkinExperts.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^login/$', AppLoginView.as_view(), name="app_login"),
    url(r'^logout/$', AppLogOutView.as_view(), name="app_logout"),
    url(r'^forgot-password/$', AppForgotPasswordView.as_view(), name="app_forgot-password"),
    url(r'^change-password/$', AppChangePasswordView.as_view(), name="app_change-password"),
    url(r'^myprofile/$', AppEditProfileView.as_view(), name="app_myprofile"),
    url(r'^episode/add/$', EpisodeAddView.as_view(), name="add_episode"),
    url(r'^reports/$', ReportListView.as_view(), name="patient_reports"),
    url(r'^reports/(?P<id>[-\w]+)/$', ReportDetailView.as_view(), name="reports_details"),
    url(r'^contact/$', AppContactView.as_view(), name="app_contact"),
)
