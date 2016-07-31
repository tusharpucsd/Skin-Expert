from django.conf.urls import patterns, url
from .views import RegisterView, LoginView, LogoutView, EditProfileView, ChangePasswordView, UserListView, UserDeleteView
from .form import CustomPasswordResetForm
 
urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'SkinExperts.views.home', name='home'),
    # url(r'^SkinExperts/', include('SkinExperts.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^$', LoginView.as_view(), name="home"),
    url(r'^users/$', UserListView.as_view(), name="users_list"),
    url(r'^users/add/$', RegisterView.as_view(), name="register"),
    url(r'^users/edit/(?P<id>[0-9]+)$', RegisterView.as_view(), name="edit_user"),
    url(r'^users/delete/$', UserDeleteView.as_view(), name="delete_user"),
    url(r'^login/$', LoginView.as_view(), name="login"),
    url(r'^logout/$', LogoutView.as_view(), name="logout"),
    url(r'^myprofile/$', EditProfileView.as_view(), name="myprofile"),
    
    url(r'^change-password/$', ChangePasswordView.as_view(), name="change-password"),
    
    url(r'^forget-password/$', 'django.contrib.auth.views.password_reset', 
        {'post_reset_redirect' : '/password/reset/done/', 'password_reset_form': CustomPasswordResetForm},
        name="password_reset"),
    url(r'^password/reset/done/$',
        'django.contrib.auth.views.password_reset_done', name="password_reset_done"),
    url(r'^password/reset/(?P<uidb36>[0-9A-Za-z]+)-(?P<token>.+)/$', 
        'django.contrib.auth.views.password_reset_confirm', 
        {'post_reset_redirect' : '/password/done/'}, name="password_reset_confirm"),
    url(r'^password/done/$', 
        'django.contrib.auth.views.password_reset_complete', name="password_reset_complete"),
)
