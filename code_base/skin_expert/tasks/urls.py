from django.conf.urls import patterns, url
from .views import TaskView, TaskAddView, TaskReviewView, TaskAuditView, TaskStaticsticsView, QueryAddView

urlpatterns = patterns('',
    url(r'^$', TaskView.as_view(), name="task_list"),
    url(r'^add/(?P<episode_no>[-\w]+)$', TaskAddView.as_view(), name="add_task"),
    url(r'^review/(?P<id>[-\w]+)$', TaskReviewView.as_view(), name="task_review"),
    url(r'^audit/$', TaskAuditView.as_view(), name="task_audit"),
    url(r'^statistics/$', TaskStaticsticsView.as_view(), name="task_staticstics"),
    url(r'^export/',TaskStaticsticsView.as_view(), name="statistics_export" ),
    url(r'^add_query/$', QueryAddView.as_view(), name="add_query"),
)